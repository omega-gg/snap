#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

deploy="../deploy"

snap="https://api.snapcraft.io/api/v1/snaps/download/RT9mcUhVsRYrDLG8qnvGiy26NKvv6Qkd_3078.snap"

#--------------------------------------------------------------------------------------------------
# Download
#--------------------------------------------------------------------------------------------------

echo "DOWNLOADING"

curl -L -o data.snap "$snap"

#--------------------------------------------------------------------------------------------------
# Extract
#--------------------------------------------------------------------------------------------------

echo "EXTRACTING"

rm -rf data

unsquashfs -f -d data data.snap

#--------------------------------------------------------------------------------------------------
# Deploy
#--------------------------------------------------------------------------------------------------

echo "DEPLOYING"

rm -rf deploy/*

touch $deploy/.gitignore

mv data/* $deploy
