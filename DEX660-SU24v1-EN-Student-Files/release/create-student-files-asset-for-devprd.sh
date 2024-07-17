#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# Creates an asset for the student files of the devprd-course (APDevPRDev) based on the current state of this repo.
# This asset is intended for a new release of this course and 
# is created as a zip file in the assets sub-directory of the current directory.
#
# The asset name will include the Mule runtime version this course release is based on
# as well as the current date (in format 07may2020). Both of these are determined automatically.
#
# Outputs to stderr the name of the asset file (which was created in the assets sub-directory):
# APDevPRDev4.3_studentFiles_07may2020.zip
#
# Just packages source code and can therefore be run from a fresh clone of this GitHub project.
#
# Usage: create-student-files-asset-for-devprd.sh [secure-props-key]

ENCRYPTKEY=${1:-1234567890123456} # Mule app secure properties en/decryption key, defaulting to formally valid key for AES

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

source set-release-vars.sh

# determine asset name from all its components
assetname="$course1""_studentFiles_$today" # APDevPRDev_studentFiles_07may2020
assetfile="$assetname.zip"                 # APDevPRDev_studentFiles_07may2020.zip

echo "Staging $assetname"
cd $assetsdir
rm -rf $assetname
# copy solutions dir in its entirety
cp -R "$solutionsdir" $assetname

# remove dir hieararchy for devint wts
rm -rf "$assetname/$wtsreldir/devint"
# overwrite pom.xml in walkthroughs dir to eliminate reference to devint dir
grep -v 'devint' "$solutionsdir/$wtsreldir/pom.xml" > "$assetname/$wtsreldir/pom.xml"

# build wt solutions for this part
echo "Building all artifacts required for $assetname"
"$assetname"/"$wtsreldir"/build.sh "$ENCRYPTKEY" true

# clean build output
echo "Cleaning all artifacts for $assetname"
"$assetname"/clean.sh

echo "Creating $assetfile"
cd $assetsdir
rm -f $assetfile
zip -r -9 $assetfile $assetname

# output to stderr the path of newly created asset, relative to the assets directory
cd $assetsdir
echo $(ls "$assetfile") 1>&2
