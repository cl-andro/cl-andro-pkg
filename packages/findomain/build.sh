CLANDRO_PKG_HOMEPAGE=https://findomain.app/
CLANDRO_PKG_DESCRIPTION="Findomain is the fastest subdomain enumerator and the only one written in Rust"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="10.0.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Findomain/Findomain/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2562943c29a9b3ce1b76685d9e7de1ad5109f80a35c6941e7853b31fb92641fa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="resolv-conf, openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	# ld: error: undefined symbol: __atomic_is_lock_free
	# ld: error: undefined symbol: __atomic_fetch_or_8
	# ld: error: undefined symbol: __atomic_load
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/hickory-resolver \
		-exec rm -rf '{}' \;

	patch --silent -p1 \
		-d ./vendor/hickory-resolver/ \
		< "$CLANDRO_PKG_BUILDER_DIR"/hickory-resolver.diff

	cat <<- EOF >> Cargo.toml

	[patch.crates-io]
	hickory-resolver = { path = "./vendor/hickory-resolver" }
	EOF

	# clash with Rust host build
	unset CFLAGS

	export OPENSSL_NO_VENDOR=1
}
