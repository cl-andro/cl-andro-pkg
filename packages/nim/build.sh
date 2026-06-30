CLANDRO_PKG_HOMEPAGE=https://nim-lang.org/
CLANDRO_PKG_DESCRIPTION="Nim programming language compiler"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="copying.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.2.6
CLANDRO_PKG_SRCURL=https://nim-lang.org/download/nim-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=657b0e3d5def788148d2a87fa6123fa755b2d92cad31ef60fd261e451785528b
CLANDRO_PKG_DEPENDS="clang, git, libandroid-glob, openssl, libandroid-spawn"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

_NIM_TOOLS="
koch
dist/nimble/src/nimble
nimpretty/nimpretty
nimsuggest/nimsuggest
testament/testament
tools/nimgrep
"

clandro_step_host_build() {
	cp -r ../src/* ./
	make -j $CLANDRO_PKG_MAKE_PROCESSES CC=gcc LD=gcc
}

clandro_step_make() {
	if [ $CLANDRO_ARCH = "x86_64" ]; then
		export	NIM_ARCH=amd64
	elif [ $CLANDRO_ARCH = "i686" ]; then
		export	NIM_ARCH=i386
	elif [ $CLANDRO_ARCH = "aarch64" ]; then
		export NIM_ARCH=arm64
	else
		export NIM_ARCH=arm
	fi
	LDFLAGS+=" -landroid-glob -landroid-spawn"
	sed -i "s%\@CC\@%${CC}%g"  config/nim.cfg
	sed -i "s%\@CFLAGS\@%${CFLAGS}%g" config/nim.cfg
	sed -i "s%\@LDFLAGS\@%${LDFLAGS}%g" config/nim.cfg
	sed -i "s%\@CPPFLAGS\@%${CPPFLAGS}%g" config/nim.cfg

	PATH=$CLANDRO_PKG_HOSTBUILD_DIR/bin:$PATH

	if [ $NIM_ARCH = "amd64" ]; then
		sed -i 's/arm64/amd64/g' makefile
	fi
	export CFLAGS=" $CPPFLAGS $CFLAGS  -w  -fno-strict-aliasing"
	make LD=$CC uos=linux mycpu=$NIM_ARCH myos=android  -j $CLANDRO_PKG_MAKE_PROCESSES useShPath=$CLANDRO_PREFIX/bin/sh
	cp config/nim.cfg ../host-build/config

	for cmd in $_NIM_TOOLS; do
		pushd $(dirname $cmd)
		case $cmd in
			koch) nim_flags="--opt:size" ;;
			dist/nimble/src/nimble) nim_flags="-d:nimNimbleBootstrap" ;; # See: https://github.com/nim-lang/nimble/issues/1248
			*) nim_flags= ;;
		esac
		nim --cc:clang --clang.exe=$CC --clang.linkerexe=$CC $nim_flags --define:termux -d:release -d:sslVersion=3 --os:android --cpu:$NIM_ARCH  -t:"$CPPFLAGS $CFLAGS" -l:"$LDFLAGS -landroid-glob" -d:tempDir:$CLANDRO_PREFIX/tmp c $(basename $cmd).nim
		popd
	done
}

clandro_step_make_install() {
	./install.sh $CLANDRO_PREFIX/lib
	ln -sfr $CLANDRO_PREFIX/lib/nim/bin/nim $CLANDRO_PREFIX/bin/
	for cmd in $_NIM_TOOLS; do
		cp $cmd $CLANDRO_PREFIX/lib/nim/bin/
		ln -sfr $CLANDRO_PREFIX/lib/nim/bin/$(basename $cmd) $CLANDRO_PREFIX/bin/
	done
	mkdir -p $CLANDRO_PREFIX/lib/nim/tools
	cp -r tools/dochack $CLANDRO_PREFIX/lib/nim/tools/
}
