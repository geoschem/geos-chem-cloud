#!/bin/bash
lsblk

DEVICE_NAME="/dev/nvme1n1"
DIR_NAME="nvme"

sudo mkfs -t ext4 $DEVICE_NAME
mkdir $DIR_NAME
sudo mount $DEVICE_NAME $DIR_NAME
df -h
sudo chown $(whoami) $DIR_NAME
