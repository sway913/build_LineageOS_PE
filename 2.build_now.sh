# https://wiki.lineageos.org/devices/jason/build

# ubuntu 1804
#
# device:mi note3

#env
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -o compression=true

#source root path.
cd ~/android/lineage

#first must do Extract proprietary blobs
# run build_proprietary.sh
if [ -d ~/android/lineage/out ] ; then
    	rm -rf ~/android/lineage/out/
fi

#build
export PHONE_NAME=jason
source build/envsetup.sh && breakfast ${PHONE_NAME} && brunch ${PHONE_NAME}
