#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

deploy="../deploy"

VLC3_version="3.0.21"
VLC4_version="4.0.0"

snap3="https://api.snapcraft.io/api/v1/snaps/download/RT9mcUhVsRYrDLG8qnvGiy26NKvv6Qkd_3777.snap"
snap4="https://api.snapcraft.io/api/v1/snaps/download/RT9mcUhVsRYrDLG8qnvGiy26NKvv6Qkd_4070.snap"

#--------------------------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------------------------

download()
{
    echo ""
    echo "DOWNLOADING $1"
    echo "$2"

    curl -L -o data.snap "$2"

    echo "EXTRACTING"

    unsquashfs -f -d data data.snap

    echo "DEPLOYING"

    mkdir -p $deploy/$1

    mv data/* $deploy/$1

    rm -rf data
}

#--------------------------------------------------------------------------------------------------
# List
#--------------------------------------------------------------------------------------------------

echo ""
echo "LISTING"

curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/vlc

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo ""
echo "CLEANING"

rm -rf deploy/*

touch $deploy/.gitignore

#--------------------------------------------------------------------------------------------------
# Download
#--------------------------------------------------------------------------------------------------

download $VLC3_version "$snap3"
download $VLC4_version "$snap4"
