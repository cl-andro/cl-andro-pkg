CLANDRO_PKG_HOMEPAGE="https://xmlrpc-c.sourceforge.io/"
CLANDRO_PKG_DESCRIPTION="XML-RPC for C and C++"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="doc/COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.64.03"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/xmlrpc-c/Xmlrpc-c%20Super%20Stable/${CLANDRO_PKG_VERSION}/xmlrpc-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=74729d364edbedbe42e782822da1e076f3f45c65c4278a3cfba5f2342d7cedbe
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_BUILD_DEPENDS="libc++, libcurl, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-cgi-server
--disable-libwww-client
--disable-libxml2-backend
--disable-wininet-client
--enable-cplusplus
"

# separate host-build directory but build system does not support out-of-tree build
clandro_step_host_build() {
	pushd $CLANDRO_PKG_HOSTBUILD_DIR
	cp -r $CLANDRO_PKG_SRCDIR/* .
	./configure

	# build only the required tool
	make -C lib/expat/gennmtab
	popd
}

clandro_step_post_configure() {
	export GENNMTAB=$CLANDRO_PKG_HOSTBUILD_DIR/lib/expat/gennmtab/gennmtab
}
