CLANDRO_PKG_HOMEPAGE=https://github.com/pgroonga/pgroonga
CLANDRO_PKG_DESCRIPTION="A PostgreSQL extension to use Groonga as index"
CLANDRO_PKG_LICENSE="PostgreSQL"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.6"
CLANDRO_PKG_SRCURL=https://github.com/pgroonga/pgroonga/releases/download/${CLANDRO_PKG_VERSION}/pgroonga-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d0048944763c18f91bc67e043aafa64c2c53f6246547c9474311efbc05ccfe66
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="groonga, libmsgpack, xxhash"
CLANDRO_PKG_BUILD_DEPENDS="postgresql"
CLANDRO_PKG_EXTRA_MAKE_ARGS="
-Dmessage_pack=enabled
-Dtest=false
-Dxxhash=enabled
"
