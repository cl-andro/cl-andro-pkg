CLANDRO_PKG_HOMEPAGE=https://github.com/rcoh/angle-grinder
CLANDRO_PKG_DESCRIPTION="Slice and dice logs on the command line"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.19.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/rcoh/angle-grinder/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f76e236f0825ca3f0b165e37d6448fa36e39c41690e7469d02c37eeb0c972222
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	# ld: error: undefined symbol: __emutls_get_address
	if [[ "${CLANDRO_ARCH}" == "arm" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}
