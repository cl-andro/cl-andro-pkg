CLANDRO_PKG_HOMEPAGE=https://github.com/metafates/mangal
CLANDRO_PKG_DESCRIPTION="Cli manga downloader"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.6"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/metafates/mangal
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o mangal
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin mangal
}
