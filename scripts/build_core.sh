#!/bin/bash

/edapack-build/scripts/init_image.sh ${@:1}

ulimit -u 16384

nprocs=`cat /proc/cpuinfo | grep 'processor' | wc -l`
nprocs=8

cd /edapack-build/scripts
if test $? -ne 0; then exit 1; fi

runuser user -c "make VERBOSE=true -j${nprocs}"
if test $? -ne 0; then exit 1; fi

