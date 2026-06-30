CLANDRO_PKG_HOMEPAGE=https://wtfutil.com/
CLANDRO_PKG_DESCRIPTION="The personal information dashboard for your terminal"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.49.1"
# Need metadata in Git repository
CLANDRO_PKG_SRCURL=git+https://github.com/wtfutil/wtf
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build -o wtfutil
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin wtfutil
}
