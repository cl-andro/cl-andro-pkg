CLANDRO_PKG_HOMEPAGE=https://boost.org
CLANDRO_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Never forget to always bump revision of reverse dependencies and rebuild them
# when bumping version.
CLANDRO_PKG_VERSION="1:1.90.0"
CLANDRO_PKG_REVISION=1
_VERSION="${CLANDRO_PKG_VERSION:2}"
CLANDRO_PKG_SRCURL="https://archives.boost.io/release/${_VERSION}/source/boost_${_VERSION//./_}.tar.bz2"
CLANDRO_PKG_SHA256=49551aff3b22cbc5c5a9ed3dbc92f0e23ea50a0f7325b0d198b705e8ee3fc305
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++, libbz2, libiconv, liblzma, zlib, libandroid-wordexp"
# Although python is a build dependency, boost needs to be rebuilt when major
# versions of python are updated to ensure that CMake's find_package detects
# Boost.Python as python version is hardcoded into it
CLANDRO_PKG_BUILD_DEPENDS="python"
CLANDRO_PKG_BREAKS="libboost-python (<= 1.65.1-2), boost-dev"
CLANDRO_PKG_REPLACES="libboost-python (<= 1.65.1-2), boost-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	CXXFLAGS+=" -std=c++14"

	rm $CLANDRO_PREFIX/lib/libboost* -f
	rm $CLANDRO_PREFIX/include/boost -rf

	CC= CXX= LDFLAGS= CXXFLAGS= ./bootstrap.sh
	echo "using clang : $CLANDRO_ARCH : $CXX : <linkflags>-L$CLANDRO_PREFIX/lib ; " >>project-config.jam
	echo "using python : ${CLANDRO_PYTHON_VERSION} : $CLANDRO_PREFIX/bin/python3 : $CLANDRO_PREFIX/include/python${CLANDRO_PYTHON_VERSION} : $CLANDRO_PREFIX/lib ;" >>project-config.jam

	if [ "$CLANDRO_ARCH" = arm ] || [ "$CLANDRO_ARCH" = aarch64 ]; then
		BOOSTARCH=arm
		BOOSTABI=aapcs
	elif [ "$CLANDRO_ARCH" = i686 ] || [ "$CLANDRO_ARCH" = x86_64 ]; then
		BOOSTARCH=x86
		BOOSTABI=sysv
	fi

	if [ "$CLANDRO_ARCH" = x86_64 ] || [ "$CLANDRO_ARCH" = aarch64 ]; then
		BOOSTAM=64
	elif [ "$CLANDRO_ARCH" = i686 ] || [ "$CLANDRO_ARCH" = arm ]; then
		BOOSTAM=32
	fi

	./b2 target-os=android -j${CLANDRO_PKG_MAKE_PROCESSES} \
		define=BOOST_FILESYSTEM_DISABLE_STATX \
		include=$CLANDRO_PREFIX/include \
		toolset=clang-$CLANDRO_ARCH \
		--prefix="$CLANDRO_PREFIX" \
		-q \
		--without-stacktrace \
		--disable-icu \
		-sNO_ZSTD=1 \
		cxxflags="$CXXFLAGS" \
		linkflags="$LDFLAGS" \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM" \
		boost.locale.icu=off \
		binary-format=elf \
		threading=multi \
		install
}
