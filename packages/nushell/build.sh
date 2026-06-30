CLANDRO_PKG_HOMEPAGE=https://www.nushell.sh
CLANDRO_PKG_DESCRIPTION="A new type of shell operating on structured data"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.112.2"
CLANDRO_PKG_SRCURL=https://github.com/nushell/nushell/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=32ebcfe41b6390145e90eb86273e221f22eeacd53ecac5274405f148fb4258c2
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_RECOMMENDS="command-not-found, termux-api"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	if [ "$CLANDRO_ARCH" = "x86_64" ]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi
}

clandro_step_post_make_install() {
	local autoload_dir="$CLANDRO_PREFIX/share/nushell/vendor/autoload"
	mkdir -p "$autoload_dir"
	sed "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|" "$CLANDRO_PKG_BUILDER_DIR/command-not-found.nu" \
		>"$autoload_dir/command-not-found.nu"
}
