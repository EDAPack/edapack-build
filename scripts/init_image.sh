#!/bin/sh -x
#****************************************************************************
#* init_image.sh
#****************************************************************************

echo "init image $*"

uid=
gid=
shell=false

while test $# -gt 0; do
  case $1 in
    -u)
        shift
        uid=$1
        ;;
    -g)
        shift
        gid=$1
        ;;

    -shell)
        shell=true
        ;;

    -*)
      echo "Error: unknown option $1"
      exit 1
      ;;
    *) 
      echo "arg: $1" 
      ;;
  esac
  shift
done

groupadd -g $gid user
if test $? -ne 0; then exit 1; fi
adduser -u $uid -g $gid user
if test $? -ne 0; then exit 1; fi

# Update process limits to permit parallel builds
if test -f /etc/security/limits.d/90-nproc.conf; then
  sed -i 's/1024/4096/g' /etc/security/limits.d/90-nproc.conf
fi

# Add the local cache directory to YUM settings
mkdir -p /edapack-build/cache
sed -i \
  -e 's%cachedir=.*$%cachedir=/edapack-build/cache/$basearch/$releasever%g' \
  -e 's%keepcache=0%keepcache=1%g' /etc/yum.conf


#DEPS="gperf bison flex wget glibc-devel.i686"
DEPS="gperf bison flex wget unzip autoconf git xz glibc-devel"
DEPS="$DEPS zlib-devel tcl tcl-devel patch"


#if test ! -f /edapack-build/build/tools.d ; then
  DEPS="$DEPS gcc gcc-c++"
#fi

cat /etc/yum.conf

#** Install dependencies
yum install -y $DEPS
if test $? -ne 0; then exit 1; fi

# Install extras repository for clang
#if test ! -f /edapack-build/cache/epel-release-6-8.noarch.rpm; then
#  wget -O /edapack-build/cache/epel-release-6-8.noarch.rpm \
#    http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#fi
#cd /edapack-build/cache
#if test $? -ne 0; then exit 1; fi
#echo "PWD=`pwd`"
#rpm -ivh epel-release-6-8.noarch.rpm
#echo "PWD=`pwd`"
#ls
#if test $? -ne 0; then exit 1; fi

#yum install -y clang libstdc++-devel
#if test $? -ne 0; then exit 1; fi

if test $shell = true; then
  runuser user
#  runuser root
fi

#yum install -y glibc-devel.i686
#if test $? -ne 0; then exit 1; fi


