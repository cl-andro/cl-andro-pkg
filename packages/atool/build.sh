CLANDRO_PKG_HOMEPAGE="https://www.nongnu.org/atool"
CLANDRO_PKG_DESCRIPTION="tool for managing file archives of various types"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.39.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://download.savannah.gnu.org/releases/atool/atool-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256="aaf60095884abb872e25f8e919a8a63d0dabaeca46faeba87d12812d6efc703b"
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RECOMMENDS="arj, llvm, bzip2, cpio, file, gzip, lhasa, lzip, lzop, p7zip, tar, unrar, unzip, xz-utils, zip"
CLANDRO_PKG_SUGGESTS="bash-completion"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX/share/bash-completion/completions"
	install -Dm600 "extra/bash-completion-atool_0.1-1" \
		"$CLANDRO_PREFIX/share/bash-completion/completions/atool"
}
