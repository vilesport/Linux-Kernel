#!/bin/sh
qemu-system-x86_64 -kernel ./files/bzImage \
  -initrd ./files/initramfs.cpio.gz -nographic \
  -append "console=ttyS0"

