#!/bin/sh

DIR1="linux-6.10.2"
DIR2="busybox-1.36.1"

if [ ! -d "$DIR1" ]
then
    if [ ! -e "$DIR1.tar.xz" ]
    then
        echo "$DIR1.tar.xz not found"
        echo "Downloading $DIR1.tar.xz"
        wget cdn.kernel.org/pub/linux/kernel/v6.x/$DIR1.tar.xz
    fi
    echo "Extracting $DIR1.tar.xz" ;
    tar -xf $DIR.tar.xz
fi

if [ ! -d "$DIR2" ]
then
    if [ ! -e "$DIR2.tar.bz2" ]
    then
        echo "$DIR2.tar.bz2 not found"
        echo "Downloading $DIR1.tar.xz"
        wget busybox.net/downloads/$DIR2.tar.bz2
    fi
    echo "Extracting $DIR2.tar.bz2" ;
    tar -xf $DIR2.tar.bz2
fi

mkdir -p ./$DIR2/Final ;
mkdir -p ./$DIR1/Final ;
mkdir ./files ;

cp ./.config_linux ./$DIR1/Final/.config ;
make --directory=./$DIR1 -j 6 O=./Final/ oldconfig ;
make --directory=./$DIR1 -j 6 O=./Final/ ;

cp ./.config_busybox ./$DIR2/Final/.config ;
make --directory=./$DIR2 -j 6 O=./Final/ oldconfig ;
make --directory=./$DIR2 -j 6 O=./Final/ ;
make --directory=./$DIR2 -j 6 O=./Final/ install ;

for dir in bin sbin etc proc sys usr/bin usr/sbin; do mkdir -p ./files/_install/$dir; done ;
cp -r ./$DIR2/Final/_install ./files/ ;
cp ./.init ./files/_install/init ;
chmod +x ./files/_install/init ;
cp ./$DIR1/Final/arch/x86/boot/bzImage ./files/bzImage ;
cd ./files/_install/ ;
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ./../initramfs.cpio.gz ;
echo "Done" ;
exit 0
