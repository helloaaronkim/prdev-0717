#!/bin/bash
# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.
set -Eeuo pipefail

# List all files that contain the Mule runtime version.
# These files must be changed when the Mule runtime version is upgraded.

scriptdir="$(cd "$(dirname "$0")" && pwd)"
cd $scriptdir

# well-known files
echo ./solutions/bom/pom.xml
echo ./doc/includes/case-study-versions-etc.adoc

# all Mule app deployment descriptors
find . -type f -name 'mule-artifact.json' | sort
