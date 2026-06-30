#!/bin/bash
if [ "$1" != "-cc1" ]; then
    $HOST_ROOTFS/$CLANDRO_STANDALONE_TOOLCHAIN/bin/clang --target=$CCCLANDRO_HOST_PLATFORM "$@"
else
    # Target is already an argument.
    $HOST_ROOTFS/$CLANDRO_STANDALONE_TOOLCHAIN/bin/clang "$@"
fi
