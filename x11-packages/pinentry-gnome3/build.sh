CLANDRO_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
CLANDRO_PKG_DESCRIPTION="GNOME 3 PIN or pass-phrase entry dialog for GnuPG"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=8e986ed88561b4da6e9efe0c54fa4ca8923035c99264df0b0464497c5fb94e9e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gcr4, libandroid-support, libassuan, libgpg-error, libiconv, ncurses"
CLANDRO_PKG_CONFLICTS="pinentry, pinentry-gtk"
CLANDRO_PKG_REPLACES="pinentry, pinentry-gtk"
CLANDRO_PKG_PROVIDES="pinentry"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pinentry-fltk
--disable-pinentry-gtk2
--disable-pinentry-qt
--enable-pinentry-gnome3
--enable-pinentry-tty
--without-libcap
"
