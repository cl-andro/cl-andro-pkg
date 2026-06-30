CLANDRO_PKG_HOMEPAGE=https://github.com/twogood/unshield
CLANDRO_PKG_DESCRIPTION="Tool and library to extract CAB files from InstallShield installers"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/twogood/unshield/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a937ef596ad94d16e7ed2c8553ad7be305798dcdcfd65ae60210b1e54ab51a2f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libiconv, openssl, openssh, zlib"

clandro_step_pre_configure() {
	LDFLAGS+=" -liconv"
}
