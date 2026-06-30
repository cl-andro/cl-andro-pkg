CLANDRO_PKG_HOMEPAGE=https://pressly.github.io/goose
CLANDRO_PKG_DESCRIPTION="A database migration tool. Supports SQL migrations and Go functions."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.27.1"
CLANDRO_PKG_SRCURL="https://github.com/pressly/goose/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=55c1da80ae3fbbb4b893dc80d569cd98d7089ccd8e54639f42a87032105556ec
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang
	go mod tidy
}

clandro_step_make() {
	go build -o goose ./cmd/goose
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin goose
}

clandro_step_install_license() {
	install -Dm600 -t "${CLANDRO_PREFIX}/share/doc/${CLANDRO_PKG_NAME}" \
		"${CLANDRO_PKG_SRCDIR}/LICENSE"
}
