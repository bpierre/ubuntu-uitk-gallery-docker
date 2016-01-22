#!/bin/sh

if [ -z "$UITK_BRANCH" ]; then
	echo "The default branch lp:ubuntu-ui-toolkit/staging will be used. Pass the name of the branch as a parameter to override it."
	UITK_BRANCH="lp:ubuntu-ui-toolkit/staging"
fi

BRANCH_PATH=$HOME/$(echo $UITK_BRANCH | md5sum | awk '{print $1}')

if [ -d "$BRANCH_PATH" ]; then
	echo "The branch already exist. Pulling changes..."
	cd $BRANCH_PATH && bzr pull
else
	echo "The branch does not exist. Fetching it..."
	bzr branch "$UITK_BRANCH" "$BRANCH_PATH"
fi

if [ $? -ne 0 ]; then
	echo "Error. Exiting..."
	exit 1
fi

cd $BRANCH_PATH && \
	qmake -makefile && \
	make -j$(nproc) && \
	./gallery.sh
