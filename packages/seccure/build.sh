CLANDRO_PKG_HOMEPAGE=http://point-at-infinity.org/seccure/
CLANDRO_PKG_DESCRIPTION="SECCURE Elliptic Curve Crypto Utility for Reliable Encryption"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=http://point-at-infinity.org/seccure/seccure-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=6566ce4afea095f83690b93078b910ca5b57b581ebc60e722f6e3fe8e098965b
CLANDRO_PKG_DEPENDS="libgcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make seccure-key
}

clandro_step_make_install() {
	install -Dm700 seccure-key "$CLANDRO_PREFIX"/bin/
	install -Dm600 seccure.1 "$CLANDRO_PREFIX"/share/man/man1/

	for i in encrypt decrypt sign verify signcrypt veridec dh; do
		ln -sfr "$CLANDRO_PREFIX"/bin/seccure-key "$CLANDRO_PREFIX"/bin/seccure-${i}
		ln -sfr "$CLANDRO_PREFIX"/share/man/man1/seccure.1 "$CLANDRO_PREFIX"/share/man/man1/seccure-${i}.1
	done
	unset i
}
