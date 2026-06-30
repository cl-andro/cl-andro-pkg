CLANDRO_PKG_HOMEPAGE=https://github.com/anordal/shellharden
CLANDRO_PKG_DESCRIPTION="The corrective bash syntax highlighter"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.3.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/anordal/shellharden/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3c16a98502df01a2fa2b81467d5232cc1aa4c80427e2ecf9f7e74591d692e22c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_SRCDIR/target/$CARGO_TARGET_NAME"/release/shellharden \
		"$CLANDRO_PREFIX"/bin/
}
