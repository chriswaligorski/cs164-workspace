#!/bin/bash

set -e

SRC=/workspace

if [ -f "/home/workspace/.version" ]; then
    # File exists
    echo "Workspace ready!"
else
    # File does not exist
	echo "It looks like this is the first time you're using the workspace. Preparing home directory..."
	sudo rsync -rahWt --remove-source-files --exclude '.version' --info=progress2 --info=name0 /workspace/ /home/workspace
    touch /home/workspace/.version
    date >> /home/workspace/.version
    echo "Workspace ready!"
fi

sudo service ssh start

echo "Docker164 ready!"

cd /home/workspace

/bin/bash

