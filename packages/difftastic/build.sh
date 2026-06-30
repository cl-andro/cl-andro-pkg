CLANDRO_PKG_HOMEPAGE="https://github.com/Wilfred/difftastic"
CLANDRO_PKG_DESCRIPTION="difft: A structural diff that understands syntax"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.69.0"
CLANDRO_PKG_SRCURL="https://github.com/Wilfred/difftastic/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=49d722fb80a0324ea99fe11907f796cde635443084d15cc6f1afd9e0de54bde0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
# needed for MIME database (optional in upstream)
CLANDRO_PKG_RECOMMENDS="file"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm644 -t "$CLANDRO_PREFIX/share/man/man1/" difft.1
}
