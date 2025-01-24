#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

deploy="../deploy"

VLC_versionA="3.0.21"
VLC_versionB="4.0.0"

snapA="https://api.snapcraft.io/api/v1/snaps/download/RT9mcUhVsRYrDLG8qnvGiy26NKvv6Qkd_3777.snap"
snapB="https://api.snapcraft.io/api/v1/snaps/download/RT9mcUhVsRYrDLG8qnvGiy26NKvv6Qkd_4070.snap"

#--------------------------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------------------------

download()
{
    echo "DOWNLOADING $1"
    echo "$2"

    curl -L -o data.snap "$2"

    echo "EXTRACTING"

    unsquashfs -f -d data data.snap

    echo "DEPLOYING"

    mkdir -p $deploy/$1

    mv data/* $deploy/$1

    rm -rf data

    echo ""
}

#--------------------------------------------------------------------------------------------------
# List
#--------------------------------------------------------------------------------------------------

echo "LISTING"

curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/vlc

echo ""

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf deploy/*

touch $deploy/.gitignore

#--------------------------------------------------------------------------------------------------
# Download
#--------------------------------------------------------------------------------------------------

download $VLC_versionA "$snapA"
download $VLC_versionB "$snapB"
