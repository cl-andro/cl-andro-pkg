CLANDRO_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
CLANDRO_PKG_DESCRIPTION="Dialog allowing secure password entry"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=8e986ed88561b4da6e9efe0c54fa4ca8923035c99264df0b0464497c5fb94e9e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libassuan, libgpg-error, libiconv, ncurses"
# --disable-pinentry-qt avoids
# /bin/bash: line 1: /data/data/com.zk.clandro/files/usr/lib/qt6/moc: cannot execute binary file: Exec format error
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pinentry-fltk
--enable-pinentry-tty
--without-libcap
--disable-pinentry-qt
"
