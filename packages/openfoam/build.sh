CLANDRO_PKG_HOMEPAGE=https://www.openfoam.com
CLANDRO_PKG_DESCRIPTION="OpenFOAM is a CFD software written in C++"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_VERSION="2412"
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL="https://develop.openfoam.com/Development/openfoam/-/archive/OpenFOAM-v${CLANDRO_PKG_VERSION}/openfoam-OpenFOAM-v${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=9d7fdfd2b93bb6296fc7604eb27528364683a19229ae319a988e4cdc95b73d9a
CLANDRO_PKG_DEPENDS="boost, libc++, libgmp, libmpfr, openmpi, readline, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, cgal, flex, libandroid-execinfo"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_RM_AFTER_INSTALL="opt/OpenFOAM-v${CLANDRO_PKG_VERSION}/build"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	(
		cd $CLANDRO_PKG_SRCDIR
		set +u
		source etc/bashrc WM_ARCH_OPTION=32 || true
		cd wmake/src
		make
		source ../../etc/bashrc WM_ARCH_OPTION=64 || true
		set -u
		make
	)
	mkdir -p platforms/tools
	mv $CLANDRO_PKG_SRCDIR/platforms/tools/linuxGcc platforms/tools/
	mv $CLANDRO_PKG_SRCDIR/platforms/tools/linux64Gcc platforms/tools/
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" == "aarch64" ]; then
		ARCH_FOLDER=linuxARM64Clang
		CLANDRO_COMPILER_PREFIX="aarch64-linux-android"
		ARCH=aarch64
	elif [ "$CLANDRO_ARCH" == "arm" ]; then
		ARCH_FOLDER=linuxARM7Clang
		CLANDRO_COMPILER_PREFIX="arm-linux-androideabi"
		ARCH=armv7l
	elif [ "$CLANDRO_ARCH" == "i686" ]; then
		ARCH_FOLDER=linuxClang
		CLANDRO_COMPILER_PREFIX="i686-linux-android"
		ARCH=i686
	elif [ "$CLANDRO_ARCH" == "x86_64" ]; then
		ARCH_FOLDER=linux64Clang
		CLANDRO_COMPILER_PREFIX="x86_64-linux-android"
		ARCH=x86_64
	fi
	sed -i "s%\@CLANDRO_COMPILER_PREFIX\@%${CLANDRO_COMPILER_PREFIX}%g" "$CLANDRO_PKG_SRCDIR/wmake/rules/General/Clang/c"
	sed -i "s%\@CLANDRO_COMPILER_PREFIX\@%${CLANDRO_COMPILER_PREFIX}%g" "$CLANDRO_PKG_SRCDIR/wmake/rules/General/Clang/c++"
	sed -i "s%\@CLANDRO_COMPILER_PREFIX\@%${CLANDRO_COMPILER_PREFIX}%g" "$CLANDRO_PKG_SRCDIR/wmake/rules/General/general"

	mkdir -p platforms/tools
	cp -r $CLANDRO_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	if [ $CLANDRO_ARCH_BITS = 32 ]; then
		cp -r $CLANDRO_PKG_HOSTBUILD_DIR/platforms/tools/linuxGcc platforms/tools/${ARCH_FOLDER}
	else
		cp -r $CLANDRO_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	fi
}

clandro_step_make() {
	# Set ARCH here again so that continued builds work
	if [ "$CLANDRO_ARCH" == "aarch64" ]; then
		ARCH=aarch64
	elif [ "$CLANDRO_ARCH" == "arm" ]; then
		ARCH=armv7l
	elif [ "$CLANDRO_ARCH" == "i686" ]; then
		ARCH=i686
	elif [ "$CLANDRO_ARCH" == "x86_64" ]; then
		ARCH=x86_64
	fi

	# Lots and lots of unset env. variables that "set -u"
	# complains about, so disable exit on error temporarily
	set +u
	source "$CLANDRO_PKG_SRCDIR"/etc/bashrc || true
	set -u
	unset LD_LIBRARY_PATH
	./Allwmake -j
	cd wmake/src
	make clean
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt
	cp -a $CLANDRO_PKG_SRCDIR $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt/OpenFOAM-v${CLANDRO_PKG_VERSION}
}

clandro_step_post_make_install() {
	sed -i 's%$ARCH%$(uname -m)%g' $CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/opt/OpenFOAM-v${CLANDRO_PKG_VERSION}/etc/config.sh/settings
}
