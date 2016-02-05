#!/bin/sh

DEFAULT_UITK_BRANCH=lp:ubuntu-ui-toolkit/staging
DOCKER_IMAGE=bpierre/ubuntu-uitk-gallery
GRID_UNIT_PX=8

show_help() {
cat << EOF
Usage: ./${0##*/} [-hc] [-i DOCKER_IMAGE] [-g GU_PX] [UI_TOOLKIT_BRANCH]

    -h              Display this help and exit.
    -i DOCKER_IMAGE Change the Docker image used to create the containers.
    -g GU_PX        Change the number of pixels per grid unit (to scale
                    things).
    -c              Remove the containers and images created by the script.
EOF
}

clean_all() {
  echo 'Clean containers...'
  docker rm $(docker ps -a | awk '/uitk_/ {print $1}')

  echo 'Clean images...'
  docker rmi  $DOCKER_IMAGE
}

# http://djm.me/ask
ask() {
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question - use /dev/tty in case stdin is redirected from
    # somewhere else
    read -p "$1 [$prompt] " REPLY </dev/tty

    # Default?
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

if ! command -v docker >/dev/null 2>&1; then
  if ask "Docker not installed. Do you want to install it now?"; then
      wget -qO- https://get.docker.com/ | sh
      sudo usermod -aG docker `whoami`
      echo "Please logout and login again, then launch the script again."
      exit 0
  fi
  echo "Exiting."
  exit 0
fi

# Get options
OPTIND=1
while getopts "hcfi:g:" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    c)
      if ask "This action will clean all the Docker images and containers created by this script. Are you sure?" N; then
        clean_all && exit 0
      else
        echo "Exiting."
        exit 0
      fi
      ;;
    i)
      DOCKER_IMAGE=$OPTARG
      ;;
    g)
      GRID_UNIT_PX=$OPTARG
      ;;
    \?)
      show_help >&2
      exit 1
      ;;
    esac
done
shift "$((OPTIND-1))"

UITK_BRANCH="$@"
if [ -z "$UITK_BRANCH" ]; then
  echo "The default branch ${DEFAULT_UITK_BRANCH} will be used."
  UITK_BRANCH="$DEFAULT_UITK_BRANCH"
fi

CID="uitk_$( \
  echo ${DOCKER_IMAGE}${GRID_UNIT_PX}${UITK_BRANCH}$CID | \
  shasum -a 1 | \
  awk '{print $1}' \
)"

IMAGE_HOSTNAME=$(docker inspect --format='{{ .Config.Hostname }}' $DOCKER_IMAGE)

# Fix a DNS issue on Ubuntu systems (when 8.8.8.8 is blocked)
DNS_PARAM=""
DISTRIBUTION_NAME=$(python -c "import platform;print(platform.linux_distribution()[0])")
if [ $DISTRIBUTION_NAME = "Ubuntu" ]; then
  if command -v nm-tool >/dev/null 2>&1; then
    dns_server=$(nm-tool | awk '/DNS/ {$1=$1;print $2}' | head -n1)
  else
    dns_server=$(nmcli dev show | awk '/IP4\.DNS/ {print $2}' | head -n1)
  fi
  DNS_PARAM="--dns=$dns_server"
fi

xhost +local:$IMAGE_HOSTNAME >/dev/null 2>&1 \
  || { echo "X11 redirection error"; exit 1; }

# Try to start an existing container…
docker start -a "$CID" 2>/dev/null

# Create it if doesn’t exist.
if [ "$?" != "0" ]; then
  docker run -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=unix$DISPLAY \
    -e UITK_BRANCH="$UITK_BRANCH" \
    --name="$CID" \
    $DNS_PARAM \
    --dns="8.8.8.8" \
    $DOCKER_IMAGE
fi

xhost -local:$IMAGE_HOSTNAME >/dev/null 2>&1 \
  || { echo "X11 redirection error"; exit 1; }
