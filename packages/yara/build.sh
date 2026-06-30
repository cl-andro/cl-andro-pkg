CLANDRO_PKG_HOMEPAGE=https://github.com/VirusTotal/yara
CLANDRO_PKG_DESCRIPTION="Tool aimed at helping malware researchers to identify and classify malware samples"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.6"
CLANDRO_PKG_SRCURL=https://github.com/VirusTotal/yara/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=6d6889b9eda324aad9e261b0a70ce4b3f381382c3d16dea2d5fd441969c1deef
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="file, openssl, libandroid-posix-semaphore"
CLANDRO_PKG_BREAKS="yara-dev"
CLANDRO_PKG_REPLACES="yara-dev"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-posix-semaphore"
	./bootstrap.sh
}
