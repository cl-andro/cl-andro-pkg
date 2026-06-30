CLANDRO_PKG_HOMEPAGE=http://www.ossp.org/pkg/lib/uuid/
CLANDRO_PKG_DESCRIPTION="ISO-C:1999 uuid generator supporting DCE 1.1, ISO/IEC 11578:1996 and RFC 4122."
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=http://www.mirrorservice.org/sites/ftp.ossp.org/pkg/lib/uuid/uuid-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=11a615225baa5f8bb686824423f50e4427acd3f70d394765bdff32801f0fd5b0
CLANDRO_PKG_BREAKS="ossp-uuid-dev"
CLANDRO_PKG_REPLACES="ossp-uuid-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--includedir=$CLANDRO_PREFIX/include/ossp-uuid"

clandro_step_pre_configure() {
	export ac_cv_va_copy=C99
}
