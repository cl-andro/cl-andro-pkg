CLANDRO_PKG_HOMEPAGE=https://github.com/sekrit-twc/zimg
CLANDRO_PKG_DESCRIPTION="Scaling, colorspace conversion, and dithering library"
CLANDRO_PKG_LICENSE="WTFPL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.6"
CLANDRO_PKG_SRCURL=https://github.com/sekrit-twc/zimg/archive/refs/tags/release-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=be89390f13a5c9b2388ce0f44a5e89364a20c1c57ce46d382b1fcc3967057577
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
