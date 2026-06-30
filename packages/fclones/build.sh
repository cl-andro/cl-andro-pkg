CLANDRO_PKG_HOMEPAGE="https://github.com/pkolaczk/fclones"
CLANDRO_PKG_DESCRIPTION="Efficient Duplicate File Finder"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.35.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/pkolaczk/fclones/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=9d8bb36076190f799f01470f80e64c6a1f15f0d938793f8f607a2544cdd6115a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	clandro_setup_rust
	cargo install \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--path $CLANDRO_PKG_SRCDIR/fclones \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $CLANDRO_PREFIX
}
