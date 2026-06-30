CLANDRO_PKG_HOMEPAGE=https://github.com/astrale-sharp/typstfmt
CLANDRO_PKG_DESCRIPTION="basic formatter for the Typst language"
CLANDRO_PKG_LICENSE=Apache-2.0
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/astrale-sharp/typstfmt/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=5a3f413a428b2590552c2d0ab0ab04c7a745e1cca128844b7b82ea49326d65c4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
