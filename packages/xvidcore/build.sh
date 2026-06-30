CLANDRO_PKG_HOMEPAGE=https://www.xvid.com/
CLANDRO_PKG_DESCRIPTION="High performance and high quality MPEG-4 library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.7
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.xvid.com/downloads/xvidcore-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=abbdcbd39555691dd1c9b4d08f0a031376a3b211652c0d8b3b8aa9be1303ce2d
CLANDRO_PKG_BREAKS="xvidcore-dev"
CLANDRO_PKG_REPLACES="xvidcore-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	rm -f $CLANDRO_PREFIX/lib/libxvid*
	export CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_BUILDDIR/build/generic
	export CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_BUILDDIR

	if [ $CLANDRO_ARCH = i686 ]; then
		# Avoid text relocations:
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-assembly"
	fi
}
