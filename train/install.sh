#!/bin/bash
# not needed anymore
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
apt-get update -q
apt-get install -y cuda-9-0
