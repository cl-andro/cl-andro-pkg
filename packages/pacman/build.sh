CLANDRO_PKG_HOMEPAGE=https://archlinux.org/pacman/
CLANDRO_PKG_DESCRIPTION="A library-based package manager with dependency support"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Maxython <mixython@gmail.com>"
CLANDRO_PKG_VERSION=7.1.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://gitlab.archlinux.org/pacman/pacman/-/releases/v${CLANDRO_PKG_VERSION}/downloads/pacman-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=530e50d7edbb2a22581c6d6707d2113240276c1bec4ee39a99488e1243c32171
CLANDRO_PKG_DEPENDS="bash, curl, gpgme, libandroid-glob, libarchive, libcurl, openssl, clandro-licenses, clandro-keyring"
CLANDRO_PKG_BUILD_DEPENDS="doxygen, asciidoc, nettle"
CLANDRO_PKG_GROUPS="base-devel"
CLANDRO_PKG_CONFFILES="etc/pacman.conf, etc/pacman.d/mirrorlist, etc/makepkg.conf, var/log/pacman.log"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--prefix=${CLANDRO_PREFIX}
--sysconfdir=${CLANDRO_PREFIX}/etc
--localstatedir=${CLANDRO_PREFIX}/var
-Dpkg-ext=.pkg.tar.xz
-Dscriptlet-shell=${CLANDRO_PREFIX}/bin/bash
-Dmakepkg-template-dir=${CLANDRO_PREFIX}/share/makepkg-template
-Di18n=false
"

clandro_step_pre_configure() {
	rm -f ./scripts/libmakepkg/executable/sudo.sh.in
	rm -f ./scripts/libmakepkg/executable/fakeroot.sh.in

	sed -i "s/@CLANDRO_ARCH@/${CLANDRO_ARCH}/" ./etc/{pacman,makepkg}.conf.in
}

clandro_step_post_configure() {
	sed -i 's/$ARGS -o $out $in $LINK_ARGS/$ARGS -o $out $in $LINK_ARGS -landroid-glob/' ${CLANDRO_PKG_BUILDDIR}/build.ninja
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/etc/pacman.d
	install -m644 $CLANDRO_PKG_BUILDER_DIR/mirrorlist $CLANDRO_PREFIX/etc/pacman.d/mirrorlist
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/bash" > postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/lib/pacman/sync" >> postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/lib/pacman/local" >> postinst
	echo "mkdir -p $CLANDRO_PREFIX/var/cache/pacman/pkg" >> postinst
	chmod 755 postinst
}
