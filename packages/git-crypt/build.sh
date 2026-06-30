CLANDRO_PKG_HOMEPAGE=https://www.agwa.name/projects/git-crypt/
CLANDRO_PKG_DESCRIPTION="Enables transparent encryption and decryption of files for a git repository"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.8.0
CLANDRO_PKG_SRCURL=https://www.agwa.name/projects/git-crypt/downloads/git-crypt-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=540d424f87bed7994a4551a8c24b16e50d3248a5b7c3fd8ceffe94bfd4af0ad9
CLANDRO_PKG_DEPENDS="git, libc++, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS=" -DCMAKE_BUILD_TYPE=Release -Dbuild_parse=yes -Dbuild_xmlparser=yes"
CLANDRO_PKG_EXTRA_MAKE_ARGS="ENABLE_MAN=yes"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# https://github.com/AGWA/git-crypt/issues/232
	CPPFLAGS+=" -DOPENSSL_API_COMPAT=0x30000000L"
	CXXFLAGS+=" $CPPFLAGS"
}
