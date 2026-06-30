CLANDRO_PKG_HOMEPAGE=https://keybase.io
CLANDRO_PKG_DESCRIPTION="Key directory that maps social media identities to encryption keys"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.2"
CLANDRO_PKG_SRCURL=https://github.com/keybase/client/releases/download/v$CLANDRO_PKG_VERSION/keybase-v$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=2d5fe090a05db8604563cbb81e99169c289d79255a96097e34aa846e7c121e54
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_REPLACES="kbfs"
CLANDRO_PKG_CONFLICTS="kbfs"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	cd go
	go mod init || :
	go mod tidy -compat=1.17
	mkdir .bin
	go build -v -tags 'production' -o ./.bin/keybase ./keybase
	go build -v -tags 'production' -o ./.bin/git-remote-keybase \
		./kbfs/kbfsgit/git-remote-keybase
	go build -v -tags 'production' -o ./.bin/kbfsfuse ./kbfs/kbfsfuse
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin \
		./go/.bin/{keybase,git-remote-keybase,kbfsfuse}
}
