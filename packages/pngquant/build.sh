CLANDRO_PKG_HOMEPAGE=https://pngquant.org
CLANDRO_PKG_DESCRIPTION="PNG image optimising utility"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later, HPND, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/kornelski/pngquant
CLANDRO_PKG_GIT_BRANCH=${CLANDRO_PKG_VERSION}
CLANDRO_PKG_DEPENDS="littlecms, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 pngquant.1
}
