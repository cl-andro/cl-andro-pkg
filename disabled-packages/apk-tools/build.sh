##
## Since Termux is continuing to use APT as package manager, abuild & apk-tools
## are disabled because don't have real use-cases currently.
##

CLANDRO_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
CLANDRO_PKG_DESCRIPTION="Alpine Linux package management tools"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.10.4
CLANDRO_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c08aa725a0437a6a83c5364a1a3a468e4aef5d1d09523369074779021397281c
CLANDRO_PKG_DEPENDS="openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="LUAAPK="
CLANDRO_PKG_CONFFILES="etc/apk/repositories"

clandro_step_post_make_install() {
    mkdir -p $CLANDRO_PREFIX/etc/apk/
    echo $CLANDRO_ARCH > $CLANDRO_PREFIX/etc/apk/arch

    echo "https://termux.net/apk/main" > $CLANDRO_PREFIX/etc/apk/repositories
}

clandro_step_post_massage() {
    mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/etc/apk/keys"
    mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/etc/apk/protected_paths.d"
    mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/lib/apk/db/"
    mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/cache/apk"

    ln -sfr \
	"$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/cache/apk" \
	"$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/etc/apk/cache"
}

clandro_step_create_debscripts() {
    {
	echo "#!$CLANDRO_PREFIX/bin/sh"
	echo "touch $CLANDRO_PREFIX/etc/apk/world"
    } > ./postinst
    chmod 755 postinst
}
