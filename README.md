# Ubuntu UITK Gallery - Docker image

Tested on Ubuntu, Debian, and Fedora hosts. OS X support via Docker Machine is planned.

## Installation

### Install Docker (if not already installed)

Either install [Docker](http://docker.com) from the website, or using these commands:

```sh
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker `whoami`
sudo service docker start
```

Logout / login again after having completed these steps.

### Download `run-gallery.sh`

```sh
curl -OL https://rawgit.com/bpierre/ubuntu-uitk-gallery-docker/master/run-gallery.sh
chmod +x ./run-gallery.sh
```

## Usage

The `run-gallery.sh` script will fetch the code, compile the project if needed, and run the gallery app.

Run it without any parameter to use the default branch, `lp:ubuntu-ui-toolkit/staging`:

```sh
./run-gallery.sh
```

To use another branch, pass it as a parameter:

```sh
./run-gallery.sh lp:ubuntu-ui-toolkit/trunk
```

Use the `-g` parameter to change the number of pixels per Grid Unit:

```sh
./run-gallery.sh -g 16
```

Use the `-c` parameter to remove all the created Docker images and containers:

```sh
./run-gallery.sh -c
```

Use the `-h` option to display the help:

```
$ ./run-gallery.sh -h
Usage: ./run-gallery.sh [-hc] [-i DOCKER_IMAGE] [-g GU_PX] [UI_TOOLKIT_BRANCH]

    -h              Display this help and exit.
    -i DOCKER_IMAGE Change the Docker image used to create the containers.
    -g GU_PX        Change the number of pixels per grid unit (to scale
                    things).
    -c              Remove the containers and images created by the script.
```

## Known Issues

On Ubuntu inside a virtual machine, the DNS resolution inside Docker containers can fail for some reason.

*Note:* In the following commands, you may need to replace `eth0` by the name of your network device. Run the command `ifconfig` to see it.

Type this command to ensure it is that exact issue:

```sh
cat /etc/resolv.conf | awk '/nameserver/ {print $2}' | grep $(nmcli device show eth0 | awk '/IP4\.DNS/ {print$2}') && echo 'OK. Nothing to do.' || echo 'NOT OK.'
```

If you see the message “NOT OK”, run the following commands to update your `/etc/resolv.conf` file:

```sh
sudo bash -c "echo nameserver $(nmcli device show eth0 | awk '/DNS/{print $2}') >> /etc/resolvconf/resolv.conf.d/tail"
sudo resolvconf -u && sudo systemctl restart network-manager
```
