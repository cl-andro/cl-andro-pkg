CLANDRO_PKG_HOMEPAGE=https://apr.apache.org/
CLANDRO_PKG_DESCRIPTION="Apache Portable Runtime Utility Library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.3
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://downloads.apache.org/apr/apr-util-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2b74d8932703826862ca305b094eef2983c27b39d5c9414442e9976a9acf1983
CLANDRO_PKG_DEPENDS="apr, libcrypt, libexpat, libiconv, libuuid"
CLANDRO_PKG_BREAKS="apr-util-dev"
CLANDRO_PKG_REPLACES="apr-util-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pq_PQsendQueryPrepared=no
--with-apr=$CLANDRO_PREFIX
--without-sqlite3
"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/aprutil.exp"
