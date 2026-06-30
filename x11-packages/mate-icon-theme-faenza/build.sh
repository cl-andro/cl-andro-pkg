CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Faenza icon theme for MATE"
CLANDRO_PKG_LICENSE="GPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.20.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop-legacy-archive/mate-icon-theme-faenza/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=3e838a08c18116d4d69fcacf50b456d79846db12bf249b44c7d971cf2df7b9c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_BUILD_DEPENDS="mate-common"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_host_build() {
	clandro_download_ubuntu_packages mate-common
	sed -i "s|prefix=/usr|prefix=$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr|" \
		"$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/bin/mate-doc-common"
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/ubuntu_packages/usr/bin:$PATH"
	fi

	./autogen.sh
}
