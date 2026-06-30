CLANDRO_PKG_HOMEPAGE=https://www.cloudwego.io
CLANDRO_PKG_DESCRIPTION="A high-performance and strong-extensibility Go HTTP framework that helps developers build microservices"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.4"
CLANDRO_PKG_SRCURL=https://github.com/cloudwego/hertz/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5761c9db43859c9b5cb9f441545bc4b334503a30fa3c349cfdeede09cadaaa9a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	cd "$CLANDRO_PKG_SRCDIR"/cmd/hz

	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR"/cmd/hz
	go build -o hz
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/cmd/hz/hz
}
