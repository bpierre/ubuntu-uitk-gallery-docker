#!/bin/sh

DOCKER_HUB_ID="bpierre/ubuntu-uitk-gallery"

if [ -z "$1" ]; then
	echo "The default branch lp:ubuntu-ui-toolkit/staging will be used."
	UITK_BRANCH="lp:ubuntu-ui-toolkit/staging"
else
	UITK_BRANCH="$1"
fi

CID="uitk_$(echo $UITK_BRANCH | md5sum | awk '{print $1}')"

docker start -a "$CID" || docker run -it \
	-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
	-e DISPLAY=unix$DISPLAY \
	-e UITK_BRANCH="$UITK_BRANCH" \
	--name="$CID" \
	$DOCKER_HUB_ID
