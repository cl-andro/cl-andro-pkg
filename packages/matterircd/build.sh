CLANDRO_PKG_HOMEPAGE=https://github.com/42wim/matterircd
CLANDRO_PKG_DESCRIPTION="Connect to your mattermost or slack using your IRC-client of choice"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.29.0"
CLANDRO_PKG_SRCURL=https://github.com/42wim/matterircd/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5746522c9d485bb3510f5a0b49390c89f66211128692a692ccee90c8d3ac63b4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/matterircd
}
