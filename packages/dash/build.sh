CLANDRO_PKG_HOMEPAGE=http://gondor.apana.org.au/~herbert/dash/
CLANDRO_PKG_DESCRIPTION="Small POSIX-compliant implementation of /bin/sh"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.12"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://git.kernel.org/pub/scm/utils/dash/dash.git/snapshot/dash-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0d632f6b945058d84809cac7805326775bd60cb4a316907d0bd4228ff7107154
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_make_install() {
	# Symlink sh -> dash
	ln -sfr $CLANDRO_PREFIX/bin/{dash,sh}
	ln -sfr $CLANDRO_PREFIX/share/man/man1/{dash,sh}.1
}
