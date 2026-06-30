CLANDRO_PKG_HOMEPAGE=https://github.com/bttger/markdown-flashcards
CLANDRO_PKG_DESCRIPTION="Small CLI app to learn with flashcards and spaced repetition"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.1"
CLANDRO_PKG_SRCURL=https://github.com/bttger/markdown-flashcards/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=90126b1f1a3e5f84a796123c42d0cbb8824e55d0d859220fe4fe049620f7c065
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o mdfc ./cmd
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin mdfc
}
