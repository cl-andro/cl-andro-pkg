CLANDRO_PKG_HOMEPAGE=https://gitea.com/gitea/runner
CLANDRO_PKG_DESCRIPTION="Gitea Actions runner"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.8
CLANDRO_PKG_SRCURL=git+https://gitea.com/gitea/runner.git
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_DEPENDS="git"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	go build -o act-runner
}

clandro_step_make_install() {
	install -Dm700 act-runner "$CLANDRO_PREFIX/bin/act-runner"
}
