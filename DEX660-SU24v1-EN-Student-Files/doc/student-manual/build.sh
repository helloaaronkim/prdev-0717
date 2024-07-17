#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# Generate Asciidoctor diagrams and main doc in HTML and PDF formats, using the Asciidoctor toolchain
#
# Usage  : build.sh <username-for-releases-ee-repo>   <password-for-releases-ee-repo> <secure-props-key-for-walkthroughs>
# Example: build.sh usernameForMuleSoftReleasesEERepo passwdForMuleSoftReleasesEERepo securePropsCryptoKeyForWalkthroughs

EE_UNAME="$1"   # username for MuleSoft releases-ee Maven/Nesus repo
EE_PASSW="$2"   # password for MuleSoft releases-ee Maven/Nesus repo
ENCRYPTKEY="$3" # Mule app secure properties en/decryption key for walkthroughs

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

./build-html-only.sh "$EE_UNAME" "$EE_PASSW" "$ENCRYPTKEY"

# generate main doc, using diagrams generated before
echo Generate main doc in PDF format
asciidoctor-pdf --verbose      \
  -r ../extensions/pom-preprocessor.rb \
  -a img=svg                   \
  -a NexusUsername="$EE_UNAME" \
  -a NexusPassword="$EE_PASSW" \
  -a EncryptKey="$ENCRYPTKEY"  \
  student-manual*.adoc
