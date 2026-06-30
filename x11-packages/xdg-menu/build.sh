CLANDRO_PKG_HOMEPAGE=https://wiki.archlinux.org/title/Xdg-menu
CLANDRO_PKG_DESCRIPTION="Tool that generates XDG Desktop Menus for icewm and other window managers"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.6.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://arch.p5n.pp.ru/~sergej/dl/2023/arch-xdg-menu-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=01cbd3749939c180fed33783f0f7c4f47ac9563af2d1c4b39e23cb6cba792b40
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_CONFFILES="
etc/update-menus.conf
etc/xdg/menus/termux-applications.menu
"

# The original "clandro_extract_src_archive" always strips the first components
# but the source of xdg-menu is directly under the root directory of the tar file
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar -xf "$file" -C "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	install -D -m 0755 xdg_menu "$CLANDRO_PREFIX"/bin/xdg_menu
	install -D -m 0755 xdg_menu_su "$CLANDRO_PREFIX"/bin/xdg_menu_su
	install -D -m 0755 update-menus "$CLANDRO_PREFIX"/bin/update-menus
	install -D -m 0644 update-menus.conf "$CLANDRO_PREFIX"/etc/update-menus.conf
	mkdir -p "$CLANDRO_PREFIX"/share/desktop-directories/
	cp termux-desktop-directories/* "$CLANDRO_PREFIX"/share/desktop-directories/
	mkdir -p "$CLANDRO_PREFIX"/etc/xdg/menus/
	cp termux-xdg-menu/* "$CLANDRO_PREFIX"/etc/xdg/menus/
}

clandro_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	set -e

	export PERL_MM_USE_DEFAULT=1

	echo "Sideloading Perl XML::Parser..."
	cpan -Ti XML::Parser

	exit 0
	POSTINST_EOF
	chmod +x ./postinst
}
