# Contributor: @Neo-Oli
CLANDRO_PKG_HOMEPAGE=https://profanity-im.github.io
CLANDRO_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
# This package depends on libpython${CLANDRO_PYTHON_VERSION}.so.
# Please revbump and rebuild when bumping CLANDRO_PYTHON_VERSION.
CLANDRO_PKG_VERSION="0.18.0"
CLANDRO_PKG_SRCURL="https://github.com/profanity-im/profanity/releases/download/$CLANDRO_PKG_VERSION/profanity-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=a1ad441bf92ba0327e0740a15dfe7885cb14415a934c850b8b98ac2f728d7cf8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gpgme, libandroid-support, libassuan, libcurl, libgcrypt, libgpg-error, libotr, libsignal-protocol-c, libsqlite, libstrophe, ncurses, python, readline"
CLANDRO_PKG_BREAKS="profanity-dev"
CLANDRO_PKG_REPLACES="profanity-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dc-plugins=enabled
-Domemo=enabled
-Dotr=enabled
-Dpgp=enabled
-Dpython-plugins=enabled
"
