CLANDRO_PKG_HOMEPAGE=https://github.com/pali/udftools
CLANDRO_PKG_DESCRIPTION="Linux tools for UDF filesystems and DVD/CD-R(W) drives"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/pali/udftools/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=095e1c8b947849f5f8a1cade23dd3375532bda305a184eb022df96e43c4d6f7e
CLANDRO_PKG_DEPENDS="readline"

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_configure() {
	local f
	for f in "$CLANDRO_PKG_SRCDIR"/include/*.h; do
		ln -sf "${f}" ./include/
	done
}
