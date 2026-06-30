CLANDRO_PKG_HOMEPAGE="https://github.com/googleprojectzero/weggli"
CLANDRO_PKG_DESCRIPTION="A fast and robust semantic search tool for C and C++ codebases"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.4"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/googleprojectzero/weggli/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=12fde9a0dca2852d5f819eeb9de85c4d11c5c384822f93ac66b2b7b166c3af78
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
}

clandro_step_pre_configure() {
	clandro_setup_rust

	# error: version script assignment of 'global' to symbol '__muloti4' failed: symbol not defined
	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
	export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=-Wl,--undefined-version"
}
