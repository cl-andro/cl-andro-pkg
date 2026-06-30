CLANDRO_PKG_HOMEPAGE=https://zk-org.github.io/zk/
CLANDRO_PKG_DESCRIPTION="A plain text note-taking assistant"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@kirasok"
CLANDRO_PKG_VERSION="0.15.4"
CLANDRO_PKG_SRCURL=https://github.com/zk-org/zk/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=024b5a1615c8ac1924ec3338b36031c36131bad5de77dcce05adce35659b7489
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
VERSION=$CLANDRO_PKG_VERSION
BUILD=
"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin zk
}
