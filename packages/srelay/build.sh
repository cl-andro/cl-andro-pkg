CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/socks-relay/
CLANDRO_PKG_DESCRIPTION="A Free SOCKS proxy server"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4.8p3
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=http://downloads.sourceforge.net/sourceforge/socks-relay/srelay-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=efa38cb3e9e745a05ccb4b59fcf5d041184f15dbea8eb80c1b0ce809bb00c924
CLANDRO_PKG_DEPENDS="libcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_CONFFILES="
etc/srelay.conf
etc/srelay.passwd
"

clandro_step_pre_configure() {
	autoreconf -fi

	export CPPFLAGS="${CPPFLAGS} -DLINUX"
}

clandro_step_make_install() {
	install -Dm755 srelay "${CLANDRO_PREFIX}/bin/srelay"
	install -Dm644 srelay.conf "${CLANDRO_PREFIX}/etc/srelay.conf"
	install -Dm644 srelay.passwd "${CLANDRO_PREFIX}/etc/srelay.passwd"
	install -Dm644 srelay.8 "${CLANDRO_PREFIX}/share/man/man8/srelay.8"
}

clandro_step_install_license() {
	install -Dm600 -t "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME" \
		"$CLANDRO_PKG_BUILDER_DIR"/LICENSE.txt
}
