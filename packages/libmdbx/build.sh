CLANDRO_PKG_HOMEPAGE=https://libmdbx.dqdkfa.ru/
CLANDRO_PKG_DESCRIPTION="An extremely fast, compact, powerful, embedded, transactional key-value database"
CLANDRO_PKG_LICENSE="OpenLDAP"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT, LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://gitflic.ru/project/erthink/libmdbx.git
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"
