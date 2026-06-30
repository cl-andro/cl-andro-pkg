CLANDRO_PKG_HOMEPAGE=https://github.com/schachmat/wego
CLANDRO_PKG_DESCRIPTION="weather app for the terminal"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4"
CLANDRO_PKG_SRCURL="https://github.com/schachmat/wego/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=5ae1c76a322ff2e295034a801755c42b0cb6bdef5ab205af42cf95dbf7c570f4
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o wego
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin wego
}
