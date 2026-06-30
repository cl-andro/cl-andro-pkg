CLANDRO_PKG_HOMEPAGE=https://jless.io
CLANDRO_PKG_DESCRIPTION="A command-line JSON viewer designed for reading, exploring, and searching through JSON data."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/PaulJuliusMartinez/jless/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=43527a78ba2e5e43a7ebd8d0da8b5af17a72455c5f88b4d1134f34908a594239
CLANDRO_PKG_BUILD_DEPENDS="libxcb"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
