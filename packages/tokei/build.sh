CLANDRO_PKG_HOMEPAGE=https://github.com/XAMPPRocky/tokei
CLANDRO_PKG_DESCRIPTION="A blazingly fast CLOC (Count Lines Of Code) program"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="14.0.0"
CLANDRO_PKG_SRCURL=https://github.com/XAMPPRocky/tokei/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4e561dbb83ef1b46359714fc623fd45eddfb14821ece63a219470500fdd1cd26
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--features all"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/tokei \
		"$CLANDRO_PREFIX"/bin/tokei
}
