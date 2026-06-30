CLANDRO_PKG_HOMEPAGE=https://launchpad.net/hollywood
CLANDRO_PKG_DESCRIPTION="Fill your console with Hollywood melodrama technobabble"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.22"
CLANDRO_PKG_REVISION=1
COMMIT="35275a68c37bbc39d8b2b0e4664a0c2f5451e5f6"
CLANDRO_PKG_SRCURL=https://github.com/dustinkirkland/hollywood/archive/${COMMIT}.tar.gz
CLANDRO_PKG_SHA256=7eab1994b4320ee8b3de751465082aed1f5fd12a8d8082ef749ed1249ea0b583
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="bmon, byobu, cmatrix, coreutils, dash, gawk, htop, mandoc, tree, util-linux"
CLANDRO_PKG_RECOMMENDS="apg"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -dm0700 "$CLANDRO_PREFIX"/{bin,lib/hollywood,share/{man/man1,hollywood}}
	install -m 0700 "$CLANDRO_PKG_SRCDIR"/bin/hollywood  "$CLANDRO_PREFIX"/bin/
	install -m 0700 "$CLANDRO_PKG_SRCDIR"/lib/hollywood/* "$CLANDRO_PREFIX"/lib/hollywood/
	install -m 0600 "$CLANDRO_PKG_SRCDIR"/share/hollywood/*  "$CLANDRO_PREFIX"/share/hollywood/
	install -m 0600 "$CLANDRO_PKG_SRCDIR"/share/man/man1/*  "$CLANDRO_PREFIX"/share/man/man1/
}
