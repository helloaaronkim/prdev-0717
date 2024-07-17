# Copyright (C) MuleSoft, Inc. All rights reserved. http://www.mulesoft.com
#
# The software in this package is published under the terms of the
# Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License,
# a copy of which has been included with this distribution in the LICENSE.txt file.

# Helper script that sets shell variables characterizing a new release of this course.
# Must be sourced from a main script located in the same directory as this script
# after scriptdir has been set and with the current dir being $scriptdir

course1="DEX660_APDevPRDev"
course2="DEX670_APDevPRInts"
solutionsdir="$scriptdir/../solutions"
wtsreldir=walkthroughs
manualdir="$scriptdir/../doc/student-manual"
manual1="$manualdir/student-manual-devprd.pdf"
manual2="$manualdir/student-manual-devint.pdf"
assetsreldir=assets
assetsdir="$scriptdir/$assetsreldir"

# determine asset name from all its components
today=$(date -u '+%d%b%Y' | tr '[:upper:]' '[:lower:]')                 # 07may2020
