CLANDRO_PKG_HOMEPAGE="https://github.com/Y2Z/monolith"
CLANDRO_PKG_DESCRIPTION="CLI tool for saving complete web pages as a single HTML file"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.10.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/Y2Z/monolith/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=1afafc94ba693597f591206938e998fcf2c78fd6695e7dfd8c19e91061f7b44a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="openssl"

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f Makefile

	# ld: error: undefined symbol: __atomic_is_lock_free
	# ld: error: undefined symbol: __atomic_fetch_or_8
	# ld: error: undefined symbol: __atomic_load
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi

	export OPENSSL_NO_VENDOR=1
}
