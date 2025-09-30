#!/bin/bash

set -e

sudo service ssh start

echo "Docker164 is ready!"

cd /home/workspace
source .bashrc

/bin/bash

