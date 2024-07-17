#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# Build the Student Manual in all supported output formats using the Asciidoctor Docker image
#
# Usage  : build-with-docker.sh <username-for-releases-ee-repo>   <password-for-releases-ee-repo> <secure-props-key-for-walkthroughs>
# Example: build-with-docker.sh usernameForMuleSoftReleasesEERepo passwdForMuleSoftReleasesEERepo securePropsCryptoKeyForWalkthroughs

EE_UNAME="$1"   # username for MuleSoft releases-ee Maven/Nesus repo
EE_PASSW="$2"   # password for MuleSoft releases-ee Maven/Nesus repo
ENCRYPTKEY="$3" # Mule app secure properties en/decryption key for walkthroughs

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

image="asciidoctor/docker-asciidoctor:latest"

# must mount this scriptdir's parent directory into the container's working directory (/documents) 
# because AsciiDoc sources use include to access files from the ../solutions directory
# then, from within the container's working directory, the build.sh script to be executed
# is located one directory down, which then is equivalent to this scriptdir
#
thisRelDir="$(basename "$scriptdir")"  # evaluates to 'doc'
parentAbsDir="$(dirname "$scriptdir")" # evaluates to absolute path of parent directory, of which doc is a direct sub-directory

#Use this line building in Linux/Mac
docker run --rm --name asciidoctor -t -v "$parentAbsDir":/documents "$image" "./$thisRelDir/build.sh" "$EE_UNAME" "$EE_PASSW" "$ENCRYPTKEY"

#Use this line building in Windows
#docker run --rm --name asciidoctor -t -v /$PWD/..:/documents "$image" "./$thisRelDir/build.sh" "$EE_UNAME" "$EE_PASSW" "$ENCRYPTKEY"
