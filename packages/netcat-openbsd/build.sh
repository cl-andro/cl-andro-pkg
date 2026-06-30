CLANDRO_PKG_HOMEPAGE=https://packages.debian.org/sid/netcat-openbsd
CLANDRO_PKG_DESCRIPTION="TCP/IP swiss army knife. OpenBSD variant."
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.234-2"
CLANDRO_PKG_SRCURL=https://salsa.debian.org/debian/netcat-openbsd/-/archive/debian/${CLANDRO_PKG_VERSION}/netcat-openbsd-debian-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=11a00e7cfb37dfd41ef6228ad4757efb45553f21f0f8709a676eb18e6f01b5ef
CLANDRO_PKG_PROVIDES="nc, ncat, netcat"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="libbsd"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	local p
	for p in $(cat debian/patches/series); do
		echo "Applying debian/patches/$p"
		patch -p1 -i "debian/patches/$p"
	done

	sed -i -e 's@-lresolv@@g' \
		-e 's@CFLAGS=@CFLAGS?=@g' \
		Makefile

	CFLAGS+=" $CPPFLAGS $LDFLAGS"
}

clandro_step_make_install() {
	install -Dm700 nc "$CLANDRO_PREFIX/bin/netcat-openbsd"
	install -Dm700 nc.1 "$CLANDRO_PREFIX/share/man/man1/netcat-openbsd.1"
}

clandro_step_install_license() {
	mkdir -p "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME"
	head -n28 netcat.c | tail -n+2 > "$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/LICENSE"
}
