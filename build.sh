#! /bin/bash

output_dir=$1

if [[ -z "${output_dir}" ]]; then
	output_dir="fribidi_libs"
fi

#BUILD_LIBS=${HOME}/${output_dir}

curDir=$(pwd)
userName="mrsimple"
BUILD_LIBS=""
if [[ $curDir == *$userName* ]]; then
	BUILD_LIBS=${HOME}/${output_dir}
else
	BUILD_LIBS="./${output_dir}"
fi

if [[ ! -d "${BUILD_LIBS}" ]]; then
	mkdir "${BUILD_LIBS}"
fi

echo "BUILD_LIBS = ${BUILD_LIBS}"

if [ -f autogen.sh ]; then
    ./autogen.sh
fi

./configure \
    --prefix=${BUILD_LIBS} \
    CFLAGS="-I${BUILD_LIBS}/include" \
    LDFLAGS="-L${BUILD_LIBS}/lib"

make

make install


export PATH=${BUILD_LIBS}/bin:${PATH}