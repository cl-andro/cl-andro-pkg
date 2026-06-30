CLANDRO_PKG_HOMEPAGE=https://optipng.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="PNG optimizer that recompresses image files to a smaller size, without losing any information"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.9.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-${CLANDRO_PKG_VERSION}/optipng-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c2579be58c2c66dae9d63154edcb3d427fef64cb00ec0aff079c9d156ec46f29
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libpng, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-system-zlib --with-system-libpng --mandir=$CLANDRO_PREFIX/share/man"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LD=$CC
}
