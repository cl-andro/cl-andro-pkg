CLANDRO_PKG_HOMEPAGE=https://github.com/FiloSottile/passage
CLANDRO_PKG_DESCRIPTION="A fork of password-store that uses age as backend"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.7.4a2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/FiloSottile/passage/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=d4bd97be2eda4249b31c2042707ef70ba50385f6fb7791598f51be794168ee2c
CLANDRO_PKG_DEPENDS="bash, age, tree"
CLANDRO_PKG_RECOMMENDS="git"
CLANDRO_PKG_SUGGESTS="pass-otp"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="WITH_ALLCOMP=yes"

clandro_step_post_configure() {
	# Replace $PREFIX with $PASS_PREFIX
	# to avoid variable name conflicts with Termux's $PREFIX
	# See: https://github.com/termux/termux-packages/issues/23569
	sed -i "s|PREFIX|PASS_PREFIX|g" src/password-store.sh
}
