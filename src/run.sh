#!/bin/bash

ARTIFACTS_PATH=/tmp/artifacts

set -e

cd /tmp

# win10 fonts
paru -G ttf-ms-win10-auto
cd ttf-ms-win10-auto
patch -u PKGBUILD -i /ttf-ms-win10-auto.patch
sed -i 's/en-us\.iso/zh-cn.iso/' PKGBUILD
paru -U --noconfirm
sudo pacman -U --noconfirm ./*-zh_cn*.pkg.tar.zst

cd /tmp

# adobe fonts
sudo paru -S --noconfirm \
    adobe-source-han-serif-cn-fonts \
    adobe-source-han-sans-cn-fonts


# compress
sudo paru -S --noconfirm zip p7zip
mkdir $ARTIFACTS_PATH
find -type f /usr/share/fonts/ -exec cp {} $ARTIFACTS_PATH/ \;
zip -r $ARTIFACTS_PATH/zh-cn-fonts.zip /usr/share/fonts 
7z a $ARTIFACTS_PATH/zh-cn-fonts.7z /usr/share/fonts 
