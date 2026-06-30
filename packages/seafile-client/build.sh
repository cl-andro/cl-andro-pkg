CLANDRO_PKG_HOMEPAGE=https://seafile.com
CLANDRO_PKG_DESCRIPTION="Seafile is a file syncing and sharing software with file encryption and group sharing"
# License: GPL-2.0-with-OpenSSL-exception
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.0.18"
CLANDRO_PKG_SRCURL=https://github.com/haiwen/seafile/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0b2a93e75b04e40c503c74059ca00b521bf981935f764efcbc5adfabff929d90
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="argon2, glib, libcurl, libevent, libjansson, libsearpc, libsqlite, libuuid, libwebsockets, openssl, python, zlib"
CLANDRO_PKG_BREAKS="seafile-client-dev, ccnet"
CLANDRO_PKG_REPLACES="seafile-client-dev, ccnet"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SETUP_PYTHON=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-python_prefix=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	./autogen.sh
	export CPPFLAGS="-I$CLANDRO_PKG_SRCDIR/lib $CPPFLAGS"
}

clandro_step_post_configure() {
	#the package has trouble to prepare some headers
	cd $CLANDRO_PKG_SRCDIR/lib
	python $CLANDRO_PREFIX/bin/searpc-codegen.py $CLANDRO_PKG_SRCDIR/lib/rpc_table.py
}
