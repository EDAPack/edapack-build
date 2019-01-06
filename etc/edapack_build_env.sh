
etc_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd)"
EDAPACK_BUILD=$(cd $etc_dir/.. ; pwd)

export PATH=$EDAPACK_BUILD/tools/python3/bin:$PATH
export PATH=$EDAPACK_BUILD/tools/gcc-4.8.5/bin:$PATH
export PATH=$EDAPACK_BUILD/tools/bison/bin:$PATH

