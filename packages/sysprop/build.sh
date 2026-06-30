CLANDRO_PKG_HOMEPAGE=https://android.googlesource.com/platform/system/tools/sysprop
CLANDRO_PKG_DESCRIPTION="Generates cpp / java sysprop"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_TAG_VERSION=13.0.0
_TAG_REVISION=15
CLANDRO_PKG_VERSION=${_TAG_VERSION}.${_TAG_REVISION}
CLANDRO_PKG_REVISION=10
CLANDRO_PKG_SRCURL=(https://android.googlesource.com/platform/system/tools/sysprop
                   https://android.googlesource.com/platform/system/core
                   https://android.googlesource.com/platform/system/libbase)
CLANDRO_PKG_GIT_BRANCH=android-${_TAG_VERSION}_r${_TAG_REVISION}
CLANDRO_PKG_SHA256=(SKIP_CHECKSUM
                   SKIP_CHECKSUM
                   SKIP_CHECKSUM)
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true
# aapt is for libandroid-base.so
CLANDRO_PKG_DEPENDS="aapt, fmt, libc++, libprotobuf"

clandro_step_post_get_source() {
	# FIXME: We would like to enable checksums when downloading
	# tar files, but they change each time as the tar metadata
	# differs: https://github.com/google/gitiles/issues/84

	for i in $(seq 0 $(( ${#CLANDRO_PKG_SRCURL[@]}-1 ))); do
		git clone --depth 1 --single-branch \
			--branch $CLANDRO_PKG_GIT_BRANCH \
			${CLANDRO_PKG_SRCURL[$i]}
	done
}

clandro_step_pre_configure() {
	clandro_setup_protobuf

	CXXFLAGS+=" -fPIC -std=c++17"
	CPPFLAGS+=" -DNDEBUG -D__ANDROID_SDK_VERSION__=__ANDROID_API__"

	_TMP_LIBDIR=$CLANDRO_PKG_SRCDIR/_lib
	rm -rf $_TMP_LIBDIR
	mkdir -p $_TMP_LIBDIR
	_TMP_BINDIR=$CLANDRO_PKG_SRCDIR/_bin
	rm -rf $_TMP_BINDIR
	mkdir -p $_TMP_BINDIR

	LDFLAGS+=" -L$_TMP_LIBDIR"
}

clandro_step_make() {
	. $CLANDRO_PKG_BUILDER_DIR/sources.sh

	local LIBBASE_SRCDIR=$CLANDRO_PKG_SRCDIR/libbase
	local LIBPROPERTYINFOPARSER_SRCDIR=$CLANDRO_PKG_SRCDIR/core/property_service/libpropertyinfoparser
	local LIBPROPERTYINFOSERIALIZER_SRCDIR=$CLANDRO_PKG_SRCDIR/core/property_service/libpropertyinfoserializer
	local SYSPROP_SRCDIR=$CLANDRO_PKG_SRCDIR/sysprop

	CPPFLAGS+=" -I. -I./include"

	# Build libpropertyinfoparser:
	cd $LIBPROPERTYINFOPARSER_SRCDIR
	for f in $libpropertyinfoparser_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$AR cru $_TMP_LIBDIR/libpropertyinfoparser.a *.o

	CPPFLAGS+=" -I$LIBPROPERTYINFOPARSER_SRCDIR/include"

	CPPFLAGS+=" -I$LIBBASE_SRCDIR/include"

	# Build libpropertyinfoserializer:
	cd $LIBPROPERTYINFOSERIALIZER_SRCDIR
	for f in $libpropertyinfoserializer_sources; do
		$CXX $CXXFLAGS $CPPFLAGS $f -c
	done
	$AR cru $_TMP_LIBDIR/libpropertyinfoserializer.a *.o

	CPPFLAGS+=" -I$LIBPROPERTYINFOSERIALIZER_SRCDIR/include"

	# Build sysprop:
	cd $SYSPROP_SRCDIR
	for f in $sysprop_proto; do
		protoc --cpp_out=. $f
	done
	local _LDFLAGS_SYSPROP="$LDFLAGS
		-landroid-base
		-lfmt
		-lpropertyinfoparser
		-lpropertyinfoserializer
		-lprotobuf"
	$CXX $CXXFLAGS $CPPFLAGS \
		$sysprop_sources \
		$sysprop_cpp_sources \
		$_LDFLAGS_SYSPROP \
		-o $_TMP_BINDIR/sysprop_cpp
	$CXX $CXXFLAGS $CPPFLAGS \
		$sysprop_sources \
		$sysprop_java_sources \
		$_LDFLAGS_SYSPROP \
		-o $_TMP_BINDIR/sysprop_java
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin \
		$_TMP_BINDIR/sysprop_{cpp,java}
}
