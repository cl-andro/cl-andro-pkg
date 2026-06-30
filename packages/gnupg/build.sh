CLANDRO_PKG_HOMEPAGE=https://www.gnupg.org/
CLANDRO_PKG_DESCRIPTION="Implementation of the OpenPGP standard for encrypting and signing data and communication"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.17"
CLANDRO_PKG_SRCURL="https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=2c1fbe20e2958fd8fb53cf37d7c38e84a900edc0d561a1c4af4bc3a10888685d
CLANDRO_PKG_DEPENDS="libassuan, libbz2, libgcrypt, libgnutls, libgpg-error, libksba, libnpth, libsqlite, readline, pinentry, resolv-conf, zlib"
CLANDRO_PKG_CONFLICTS="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
CLANDRO_PKG_REPLACES="gnupg2 (<< 2.2.9-1), dirmngr (<< 2.2.17-1)"
CLANDRO_PKG_SUGGESTS="scdaemon"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ldap
--enable-sqlite
--enable-tofu
ac_cv_path_YAT2M=$CLANDRO_PKG_HOSTBUILD_DIR/doc/yat2m
"
# Remove non-english help files and man pages shipped with the gnupg (1) package:
CLANDRO_PKG_RM_AFTER_INSTALL="share/gnupg/help.*.txt share/man/man1/gpg-zip.1 share/man/man7/gnupg.7"

# gnupg 2.5.5 needs a newer yat2m version than ubuntu 24.04
# provides. Therefore download also libgpg-error sources and hostbuild
# the tool.
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	LIBGPG_ERROR_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/libgpg-error/build.sh; echo $CLANDRO_PKG_VERSION)
	LIBGPG_ERROR_SRCURL=$(. $CLANDRO_SCRIPTDIR/packages/libgpg-error/build.sh; echo $CLANDRO_PKG_SRCURL)
	LIBGPG_ERROR_SHA256=$(. $CLANDRO_SCRIPTDIR/packages/libgpg-error/build.sh; echo $CLANDRO_PKG_SHA256)

	clandro_download \
		$LIBGPG_ERROR_SRCURL \
		$CLANDRO_PKG_CACHEDIR/libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2 \
		$LIBGPG_ERROR_SHA256
	tar xf $CLANDRO_PKG_CACHEDIR/libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2
	./libgpg-error-${LIBGPG_ERROR_VERSION}/configure
	make -C doc yat2m
}

clandro_step_pre_configure() {
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/doc/:$PATH"
	CPPFLAGS+=" -Ddn_skipname=__dn_skipname"
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/bin
	ln -sf gpg gpg2
}
