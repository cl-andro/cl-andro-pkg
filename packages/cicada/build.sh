CLANDRO_PKG_HOMEPAGE=https://github.com/mitnk/cicada
CLANDRO_PKG_DESCRIPTION="A bash like Unix shell"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="1.2.2"
CLANDRO_PKG_SRCURL=https://github.com/mitnk/cicada/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=64e2c42b800dd7ea502ffd4eb9a99d4c5e4d40bf354d7d2e1f9aae5eafda04e6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f Makefile

	if [ "$CLANDRO_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi
}
