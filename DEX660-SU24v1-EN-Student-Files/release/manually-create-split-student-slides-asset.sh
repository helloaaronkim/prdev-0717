#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail


FILE=${1} # Instructor Slides zip file to split
VERSION=${2} # Version number to add to split files
# Manual quick hack for now
scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

echo $(pwd)
source set-release-vars.sh



f="$(basename -- $FILE .zip)"
assetname="split""$f"				
assetfile="$assetname"                       
echo "Staging $assetname"
cd $assetsdir
rm -rf $assetname && mkdir $assetname
cd $assetname
mkdir tosplit
cd tosplit
unzip "$FILE" # unzip slide PDFs to split to slides directory
# TODO: overwrite with SP-only slide PDFs
# TODO ...
cd ..
# split with config for this course, creating child PDFs in current dir
image="integrational/training-pdf-splitter"
docker pull $image
docker run --rm -t -v $(pwd):/work $image --out=slides- --devl2 tosplit/*.pdf
rm -rf tosplit                                   # remove slide PDFs that were split

# output to stderr the path of newly created asset, relative to the assets directory
cd $assetsdir
echo $(ls "$assetfile") 1>&2
cd $assetfile

if [[ $assetname == *"$course1"* ]]; then
  echo "Using mappings file for $course1"
  mappings="$scriptdir/slide-mappings-devprd.csv"
elif [[ $assetname == *"$course2"* ]]; then
  echo "Using mappings file for $course1"
  mappings="$scriptdir/slide-mappings-devint.csv"
else
  echo "No mappings file found for course"
  exit 1
fi

while IFS=, read -r orig target; do
	echo $(pwd)
	etarget=$(eval echo "$target")
	mv "$orig"  "$etarget" || true
done < $mappings

