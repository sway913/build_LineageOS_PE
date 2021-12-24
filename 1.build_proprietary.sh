#!/bin/bash

# https://wiki.lineageos.org/extracting_blobs_from_zips#extracting-proprietary-blobs-from-block-based-otas
# https://download.lineageos.org/jason

# ubuntu 1804
#
# device:mi note3
# download installable zip:lineage-18.1-20211222-nightly-jason-signed.zip(rename:lineage-18.1.zip)

if [ -d ~/android/system_dump/ ] ; then
	if [ -d ~/android/system_dump/system/vendor ] ; then
    		sudo umount ~/android/system_dump/system/vendor
	fi

	if [ -d ~/android/system_dump/system ] ; then
    		sudo umount ~/android/system_dump/system
	fi
    	rm -rf ~/android/system_dump/
fi

if [$# -eq 1] ; then
	echo "nothing to do."
        exit
fi

#create temp path.
mkdir ~/android/system_dump/


cd ~/android/system_dump/

sudo apt-get install brotli

unzip ~/android/lineage-18.1.zip system.transfer.list system.new.dat*

unzip ~/android/lineage-18.1.zip vendor.transfer.list vendor.new.dat*


brotli --decompress --output=system.new.dat system.new.dat.br

brotli --decompress --output=vendor.new.dat vendor.new.dat.br

if [ ! -d "sdat2img" ] ; then
    git clone https://github.com/xpirt/sdat2img
fi

python sdat2img/sdat2img.py system.transfer.list system.new.dat system.img

mkdir system/
sudo mount system.img system/

python sdat2img/sdat2img.py vendor.transfer.list vendor.new.dat vendor.img

sudo rm -rf system/vendor
sudo mkdir system/vendor
sudo mount vendor.img system/vendor/


cd  ~/android/lineage/device/xiaomi/jason

./extract-files.sh ~/android/system_dump/


