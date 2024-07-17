#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# Creates an asset for the split student manual of the devint-course (APDevPRInts) based on the current state of this repo.
# This asset is intended for a new release of this course and 
# is created as a zip file in the assets sub-directory of the current directory.
#
# The asset name will include the Mule runtime version this course release is based on
# as well as the current date (in format 07may2020). Both of these are determined automatically.
#
# Outputs to stderr the name of the asset file (which was created in the assets sub-directory):
# APDevPRInts4.3_studentManual_split_07may2020.zip
#
# Assumes that the student manual is already built and committed to GitHub
# and can therefore be run from a fresh clone of this GitHub project.
#
# Usage: create-split-student-manual-asset-for-devint.sh <version>

VERSION=${1} # Version number to add to split files

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

source set-release-vars.sh

# determine asset name from all its components
assetname="$course2""_studentManual_split_$today" # APDevPRInts_studentManual_split_07may2020
assetfile="$assetname.zip"                        # APDevPRInts_studentManual_split_07may2020.zip

echo "Staging $assetname"
cd $assetsdir
rm -rf $assetname && mkdir $assetname
cd $assetname
cp "$manual2" ./manual.pdf                                    # copy manual to split
# split with config for this course, creating child PDFs in current dir
image="integrational/training-pdf-splitter"
docker pull $image
docker run --rm -t -v $(pwd):/work $image --pdf=manual.pdf --moduleNumberOffset=-1
rm -f manual.pdf # remove manual that was split
echo "Renaming ouptut"
while IFS=, read -r orig target; do
	echo $(pwd)
	etarget=$(eval echo "$target")
	mv "$orig"  "$etarget" || true
done < "$scriptdir/manual-mappings-devint.csv"

echo "Creating $assetfile"
cd $assetsdir
rm -f $assetfile
zip -r -9 $assetfile $assetname

# output to stderr the path of newly created asset, relative to the assets directory
cd $assetsdir
echo $(ls "$assetfile") 1>&2
