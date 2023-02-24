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

curl -L -o archive.json "$snap"

#--------------------------------------------------------------------------------------------------
# Extract
#--------------------------------------------------------------------------------------------------

unsquashfs -f -d data archive.snap

#--------------------------------------------------------------------------------------------------
# Deploy
#--------------------------------------------------------------------------------------------------

rm -rf $deploy

touch $deploy/.gitignore

mv data/* $deploy
