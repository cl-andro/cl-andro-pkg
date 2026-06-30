CLANDRO_PKG_HOMEPAGE=https://www.softsynth.com/pforth/
CLANDRO_PKG_DESCRIPTION="Portable Forth in C"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_LICENSE_FILE="license.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:2.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/philburk/pforth/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=f4c417d7d1f2c187716263484bdc534d3224b6d159e049d00828a89fa5d6894d
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_host_build() {
	clandro_setup_cmake

	cp -a $CLANDRO_PKG_SRCDIR/* .

	mkdir -p 32bit
	# Add -Wno-shift-count-overflow to ignore:
	# /home/builder/.termux-build/pforth/src/csrc/pf_save.c:223:34: error: right shift count >= width of type [-Werror=shift-count-overflow
	#   223 |         *addr++ = (uint8_t) (data>>56);
	#       |                                  ^~
	CC="gcc -m32" CFLAGS="-Wno-shift-count-overflow" cmake .
	make
	install -m700 fth/pforth 32bit/
	install -m600 csrc/pfdicdat.h 32bit/

	rm -rf CMakeCache.txt CMakeFiles

	mkdir -p 64bit
	cmake .
	make
	install -m700 fth/pforth 64bit/
	install -m600 csrc/pfdicdat.h 64bit/
}

clandro_step_post_configure() {
	if [ $CLANDRO_ARCH_BITS = "32" ]; then
		local folder=32bit
	else
		local folder=64bit
	fi
	cp $CLANDRO_PKG_HOSTBUILD_DIR/$folder/pforth fth/
	cp $CLANDRO_PKG_HOSTBUILD_DIR/$folder/pfdicdat.h csrc/
}

clandro_step_make_install() {
	install -m700 fth/pforth_standalone $CLANDRO_PREFIX/bin/pforth
}
