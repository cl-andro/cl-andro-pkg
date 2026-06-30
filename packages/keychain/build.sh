CLANDRO_PKG_HOMEPAGE=https://www.funtoo.org/Keychain
CLANDRO_PKG_DESCRIPTION="keychain ssh-agent front-end"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.9.8"
CLANDRO_PKG_SRCURL=https://github.com/funtoo/keychain/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=589cf55ae5c4b65af1d977d705beb319006efca5bcdda8352b8558d0dcff5a84
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="dash, gnupg"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm700 keychain "${CLANDRO_PREFIX}"/bin/keychain
	install -Dm600 keychain.1 "${CLANDRO_PREFIX}"/share/man/man1/keychain.1
}
