CLANDRO_PKG_HOMEPAGE=https://www.gnupg.org/related_software/gpgme/
CLANDRO_PKG_DESCRIPTION="Library designed to make access to GnuPG easier"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1, MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.LESSER, LICENSES"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.1"
CLANDRO_PKG_SRCURL="https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=821ab0695c842eab51752a81980c92b0410c7eadd04103f791d5d2a526784966
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gnupg (>= 2.2.9-1), libassuan, libgpg-error"
CLANDRO_PKG_BREAKS="gpgme-dev"
CLANDRO_PKG_REPLACES="gpgme-dev"
# Use "--disable-gpg-test" to avoid "No rule to make target `../../src/libgpgme-pthread.la":
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gpg-test
--with-gpg=$CLANDRO_PREFIX/bin/gpg2
--without-g13
--without-gpgconf
--without-gpgsm
ac_cv_path_YAT2M=:
"

clandro_step_pre_configure() {
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
