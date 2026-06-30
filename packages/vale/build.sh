CLANDRO_PKG_HOMEPAGE=https://vale.sh
CLANDRO_PKG_DESCRIPTION="A syntax-aware linter for prose built with speed and extensibility in mind"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.14.1"
CLANDRO_PKG_SRCURL=https://github.com/errata-ai/vale/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2b56cb18274a881c8d18d4751cd8c05283529ca8e4934fc0ff8f059113131c86
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR"/cmd/vale
	go build -o vale -ldflags="-s -w -X 'main.version=${CLANDRO_PKG_VERSION}'"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/cmd/vale/vale
}
