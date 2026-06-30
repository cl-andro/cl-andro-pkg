CLANDRO_PKG_HOMEPAGE=http://dar.linux.free.fr/
CLANDRO_PKG_DESCRIPTION="A full featured command-line backup tool, short for Disk ARchive"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.5"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/dar/dar/${CLANDRO_PKG_VERSION}/dar-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9f3f9a7b344efba1672050d13b841e3834cef611a95be3ead50d69d5537828b2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="attr, libbz2, libc++, libgcrypt, libgpg-error, liblzma, liblzo, zlib, zstd"
CLANDRO_PKG_BUILD_IN_SRC=
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-dar-static"

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH_BITS" = "32" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=32"
	else
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-mode=64"
	fi
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
