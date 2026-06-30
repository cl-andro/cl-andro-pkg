CLANDRO_PKG_HOMEPAGE=http://www.catb.org/~esr/open-adventure/
CLANDRO_PKG_DESCRIPTION="Forward-port of the original Colossal Cave Adventure from 1976-77"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="1.20"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.com/esr/open-adventure/-/archive/${CLANDRO_PKG_VERSION}/open-adventure-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fa2e47cf30aaa8d90bb68a6f6b2d4f7e3bc65cc794f7b81edb7dce378c313e01
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libedit"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_make_install () {
	install -m 0755 advent $CLANDRO_PREFIX/bin
}
