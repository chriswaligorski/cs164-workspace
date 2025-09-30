#!/bin/bash

set -e

sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
sudo /run/sshd &

echo "Docker164 is ready!"

cd /home/workspace

/bin/bash

