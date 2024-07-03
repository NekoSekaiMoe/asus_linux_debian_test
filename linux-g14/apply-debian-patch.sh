#!/usr/bin/env bash

set -x

if [ ! -f .git ]; then
    exit 1
fi
if [ ! -f .config]; then
    exit 1
fi

git clone https://salsa.debian.org/kernel-team/linux.git
git apply $(find linux/debian/patches -name *.patch)
rm -rf linux.git

exit 0
