#!/bin/bash

# https://wiki.lineageos.org/devices/jason/build

# ubuntu 1804
#
# device:mi note3

#env
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -o compression=true

#init
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --depth 1

#sync code
repo sync -j4
while [$? -ne 0]
do 
	repo sync -j4
done
