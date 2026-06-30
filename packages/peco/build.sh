CLANDRO_PKG_HOMEPAGE=https://github.com/peco/peco
CLANDRO_PKG_DESCRIPTION="Simplistic interactive filtering tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_SRCURL=https://github.com/peco/peco/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=480ba339c5b15ebb9eada276d5e25315ee5c36e878d86dcfc1ea17f54a27197a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR"/cmd/peco
	go build -o peco
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/cmd/peco/peco
}
