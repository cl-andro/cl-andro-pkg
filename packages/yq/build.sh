CLANDRO_PKG_HOMEPAGE=https://mikefarah.gitbook.io/yq/
CLANDRO_PKG_DESCRIPTION="A lightweight and portable command-line YAML, JSON and XML processor"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.53.2"
CLANDRO_PKG_SRCURL=https://github.com/mikefarah/yq/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1bc19bb8b1029148afa3465a9383f6dcccb1ecce28a0af1d81f07c93396ce37d
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_REPLACES="xpup"

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin yq
}
