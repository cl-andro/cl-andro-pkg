CLANDRO_PKG_HOMEPAGE=https://git.sr.ht/~delthas/senpai
CLANDRO_PKG_DESCRIPTION="An IRC client that works best with bouncers"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.4.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://git.sr.ht/~delthas/senpai/archive/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=ab786b7b3cffce69d080c3b58061e14792d9065ba8831f745838c850acfeab24
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}
