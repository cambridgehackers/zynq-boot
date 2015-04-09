#!/system/bin/sh
set -x
set -e
echo running "/zynqmodules.sh"
insmod /mnt/sdcard/portalmem.ko
insmod /mnt/sdcard/zynqportal.ko
