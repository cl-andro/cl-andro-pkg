CLANDRO_PKG_HOMEPAGE=https://codeberg.org/emersion/soju
CLANDRO_PKG_DESCRIPTION="A user-friendly IRC bouncer"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.1"
CLANDRO_PKG_SRCURL=https://codeberg.org/emersion/soju/archive/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3dddf2746fc9b68967afaac188751f35d72e3db5f946c04dd927b5d2ec786ef4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	mkdir -p $CLANDRO_PREFIX/var/lib/soju
	EOF
}
