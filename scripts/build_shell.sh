#!/bin/sh

scripts_dir=$(dirname $0)
scripts_dir=$(cd $scripts_dir ; pwd)
edapack_build=$(dirname $scripts_dir)

docker run -it -v $edapack_build:/edapack-build centos:6.10 \
	/edapack-build/scripts/init_image.sh \
	-u `id -u` \
	-g `id -g` \
	-shell

