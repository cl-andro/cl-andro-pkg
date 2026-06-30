CLANDRO_PKG_HOMEPAGE=http://www.pps.jussieu.fr/~jch/software/polipo/
CLANDRO_PKG_DESCRIPTION="A small and fast caching web proxy"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://www.pps.univ-paris-diderot.fr/~jch/software/files/polipo/polipo-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a259750793ab79c491d05fcee5a917faf7d9030fb5d15e05b3704e9c9e4ee015
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/polipo/config"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

clandro_step_post_make_install() {
	install -Dm600 config.sample "$CLANDRO_PREFIX"/etc/polipo/config.sample
	install -Dm600 forbidden.sample "$CLANDRO_PREFIX"/etc/polipo/forbidden.sample
	install -Dm600 "$CLANDRO_PKG_BUILDER_DIR"/termux.config \
		"$CLANDRO_PREFIX"/etc/polipo/config
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/cache/polipo
}
