CLANDRO_PKG_HOMEPAGE=https://github.com/vmchale/tin-summer
CLANDRO_PKG_DESCRIPTION="Find build artifacts that are taking up disk space"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.21.14
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/vmchale/tin-summer/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=8a4883b7a6354c6340e73a87d1009c0cc79bdfa135fe947317705dad9f0a6727
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	sed -i 's/linux/android/g' src/utils.rs
}
