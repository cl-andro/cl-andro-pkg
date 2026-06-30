CLANDRO_PKG_HOMEPAGE=https://github.com/Canop/broot
CLANDRO_PKG_DESCRIPTION="A better way to navigate directories"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.56.2"
CLANDRO_PKG_SRCURL=https://github.com/Canop/broot/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3e7be4252c76565f6d71b34bd07d26e1444b9ac2e1c8271c724f6e866fe75565
CLANDRO_PKG_DEPENDS="libgit2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
	sed -i '/trash/d' $CLANDRO_PKG_SRCDIR/Cargo.toml
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release

	mkdir -p build
	cp man/page build/broot.1
	sed -i "s/#version/$CLANDRO_PKG_VERSION/g" build/broot.1
	sed -i "s/#date/$(date -r man/page +'%Y\/%m\/%d')/g" build/broot.1

}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/broot
	install -Dm644 -t $CLANDRO_PREFIX/share/man/man1 build/broot.1
}
