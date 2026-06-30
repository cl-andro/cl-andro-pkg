CLANDRO_PKG_HOMEPAGE=https://www.ledger-cli.org
CLANDRO_PKG_DESCRIPTION="Powerful, double-entry accounting system"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/ledger/ledger/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1cf012cdc8445cab0efc445064ef9b2d3f46ed0165dae803c40fe3d2b23fdaad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, libc++, libedit, libmpfr, libgmp, python"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, utf8cpp"
CLANDRO_PKG_BREAKS="ledger-dev"
CLANDRO_PKG_REPLACES="ledger-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_PYTHON=ON
-DUTFCPP_PATH=$CLANDRO_PREFIX/include/utf8cpp
"

clandro_step_pre_configure() {
	clandro_setup_python_pip
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DPython3_EXECUTABLE=$(command -v cross-python)"
}
