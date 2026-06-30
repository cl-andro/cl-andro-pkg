CLANDRO_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
CLANDRO_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
CLANDRO_PKG_LICENSE="AGPL-V3"
# We override CLANDRO_PKG_SRCDIR clandro_step_pre_configure so need to do
# this hack to be able to find the license file.
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=18.1.40
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://fossies.org/linux/misc/db-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0cecb2ef0c67b166de93732769abdeba0555086d51de1090df325e18ee8da9c8
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BREAKS="libdb-dev"
CLANDRO_PKG_REPLACES="libdb-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hash
--enable-smallbuild
--enable-compat185
db_cv_atomic=gcc-builtin
--enable-cxx
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR/dist

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
