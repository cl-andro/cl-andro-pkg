CLANDRO_PKG_HOMEPAGE=https://github.com/rofl0r/proxychains-ng
CLANDRO_PKG_DESCRIPTION="A hook preloader that allows to redirect TCP traffic of existing dynamically linked programs through one or more SOCKS or HTTP proxies"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.17
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/rofl0r/proxychains-ng/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=1a2dc68fcbcb2546a07a915343c1ffc75845f5d9cc3ea5eb3bf0b62a66c0196f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_post_make_install() {
	# Remove conf file from previous build, otherwise nothing will be done and it won't be included in the package
	rm -f "$CLANDRO_PREFIX"/etc/proxychains.conf
	make install-config
}
