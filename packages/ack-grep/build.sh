CLANDRO_PKG_HOMEPAGE=https://beyondgrep.com/
CLANDRO_PKG_DESCRIPTION="Tool like grep optimized for programmers"
CLANDRO_PKG_LICENSE="Artistic-License-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(3.9.0
					1.18)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=("https://github.com/beyondgrep/ack3/archive/refs/tags/v${CLANDRO_PKG_VERSION[0]}.tar.gz"
					"https://github.com/petdance/file-next/archive/refs/tags/${CLANDRO_PKG_VERSION[1]}.tar.gz")
CLANDRO_PKG_SHA256=(b2233b9f30b7099db2bad9d6b7e7f7e1003a73ce24353b92b8e904d5b44fedf7
					e3c56f0bdcb3251a2e22b9ffc3c7cbf99b1433a45fc8a07f8e2e66174bc3963f)
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	# build and install build dependency petdance/file-next
	pushd "file-next-${CLANDRO_PKG_VERSION[1]}"
	perl Makefile.PL PREFIX="$CLANDRO_PKG_TMPDIR"
	make
	make install
	popd
	export PERL5LIB="$CLANDRO_PKG_TMPDIR/share/perl"
}

clandro_step_configure() {
	perl Makefile.PL
}

clandro_step_make() {
	make ack-standalone
}

clandro_step_make_install() {
	install -Dm755 ack-standalone "$CLANDRO_PREFIX/bin/ack"
}
