CLANDRO_PKG_HOMEPAGE=https://mariadb.com/docs/clients/mariadb-connectors/connector-cpp/
CLANDRO_PKG_DESCRIPTION="Enables C++ applications to establish client connections to MariaDB Enterprise over TLS"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/mariadb-corporation/mariadb-connector-cpp
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_DEPENDS="libc++, openssl, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DINSTALL_LIB_SUFFIX=lib
-DINSTALL_LIBDIR=lib/mariadbcpp
-DINSTALL_PLUGINDIR=lib/mariadbcpp/plugin
-DINSTALL_DOCDIR=share/doc/$CLANDRO_PKG_NAME
-DINSTALL_LICENSEDIR=share/doc/$CLANDRO_PKG_NAME
-DWITH_EXTERNAL_ZLIB=ON
"

clandro_step_pre_configure() {
	LDFLAGS="-Wl,-rpath=$CLANDRO_PREFIX/lib/mariadbcpp $LDFLAGS"
}
