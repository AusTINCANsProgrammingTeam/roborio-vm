#!/bin/bash -e

cd `dirname $0`
source params

if [ ! -f linux/uImage ]; then
  echo "Cannot find kernel, run ./get_linux.sh first!"
  exit 1
fi


qemu-system-arm \
  -machine xilinx-zynq-a9 -cpu cortex-a9 -m $RAM_SIZE \
  -kernel linux/uImage -dtb linux/devicetree.dtb \
  -display none -serial null -serial mon:stdio \
  -append "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0 rw" \
  -rtc base=localtime \
  -net user,hostfwd=tcp::${LOCAL_SSH_PORT}-:22 \
  -net nic \
  -sd "$IMG_FILE"
  
# TODO: how to safely shutdown the system?
