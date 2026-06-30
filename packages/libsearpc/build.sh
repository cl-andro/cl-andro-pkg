CLANDRO_PKG_HOMEPAGE=https://github.com/haiwen/libsearpc
CLANDRO_PKG_DESCRIPTION="A simple C language RPC framework (mainly for seafile)"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:3.2.0
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL=https://github.com/haiwen/libsearpc/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=cd00197fcc40b45b1d5e892b2d08dfa5947f737e0d80f3ef26419334e75b0bff
CLANDRO_PKG_DEPENDS="glib, libjansson, python"
CLANDRO_PKG_BREAKS="libsearpc-dev"
CLANDRO_PKG_REPLACES="libsearpc-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-compile-demo=no
"

clandro_step_post_get_source() {
	./autogen.sh
}

clandro_step_pre_configure() {
	clandro_setup_python_pip
	export PYTHON="cross-python"
}
