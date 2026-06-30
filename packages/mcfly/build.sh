CLANDRO_PKG_HOMEPAGE=https://github.com/cantino/mcfly
CLANDRO_PKG_DESCRIPTION="Replaces your default ctrl-r shell history search with an intelligent search engine"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.4"
CLANDRO_PKG_SRCURL=https://github.com/cantino/mcfly/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=31cdd76bfab3b05b4873bc20f03eb022e5a5d68f6595bc6df5dd9fce4b519e53
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mcfly
	install -Dm600 -t $CLANDRO_PREFIX/share/mcfly mcfly.{ba,fi,z}sh
}
