CLANDRO_PKG_HOMEPAGE=https://neomutt.org/
CLANDRO_PKG_DESCRIPTION="A version of mutt with added features"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20260504"
CLANDRO_PKG_SRCURL=https://github.com/neomutt/neomutt/archive/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=93fd8344c12cd857f084f8d7cc1187479f79036ab9725cfdbc81c0cc845f1615
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d{8}"
CLANDRO_PKG_DEPENDS="gdbm, krb5, libandroid-support, libiconv, libsasl, ncurses, notmuch, openssl, zlib, zstd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="etc/neomuttrc"

clandro_step_configure() {
	./configure --host=$CLANDRO_HOST_PLATFORM \
		--sysroot=$CLANDRO_PREFIX \
		--prefix=$CLANDRO_PREFIX --with-mailpath=$CLANDRO_PREFIX/var/mail \
		--notmuch \
		--disable-gpgme --disable-idn --zlib --zstd --sasl --ssl --gdbm --gss
}
