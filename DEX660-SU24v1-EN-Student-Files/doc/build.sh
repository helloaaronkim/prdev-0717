#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# Build the Student Manual in all supported output formats in an environment where the Asciidoctor toolchain is available
#
# Usage  : build.sh <username-for-releases-ee-repo>   <password-for-releases-ee-repo> <secure-props-key-for-walkthroughs>
# Example: build.sh usernameForMuleSoftReleasesEERepo passwdForMuleSoftReleasesEERepo securePropsCryptoKeyForWalkthroughs

EE_UNAME="$1"   # username for MuleSoft releases-ee Maven/Nesus repo
EE_PASSW="$2"   # password for MuleSoft releases-ee Maven/Nesus repo
ENCRYPTKEY="$3" # Mule app secure properties en/decryption key for walkthroughs

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

cd student-manual
./build.sh "$EE_UNAME" "$EE_PASSW" "$ENCRYPTKEY"