CLANDRO_PKG_HOMEPAGE=https://github.com/knqyf263/pet
CLANDRO_PKG_DESCRIPTION="Simple command-line snippet manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/knqyf263/pet/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b829628445b8a7039f0211fd74decee41ee5eb1c28417a4c8d8fca99de59091f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="fzf"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o pet -ldflags="-s -w -X 'github.com/knqyf263/pet/cmd.version=${CLANDRO_PKG_VERSION}'"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/pet
}
