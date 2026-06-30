CLANDRO_PKG_HOMEPAGE=https://forgejo.org/
CLANDRO_PKG_DESCRIPTION="Forgejo is a self-hosted lightweight software forge."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="15.0.1"
CLANDRO_PKG_SRCURL="https://codeberg.org/forgejo/forgejo/archive/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=8775c6ca86a7a7fbd8244e6733edbf696a85e92e4760e4e1264370a665c89ecb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dash, git"
CLANDRO_PKG_CONFFILES="etc/forgejo/app.ini"

clandro_step_pre_configure() {
	clandro_setup_nodejs
	clandro_setup_golang
}

clandro_step_make() {
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/forgejo.org
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/forgejo.org/forgejo
	cd "$GOPATH"/src/forgejo.org/forgejo

	go mod init || :
	go mod tidy

	LDFLAGS=""
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.CustomConf=$CLANDRO_PREFIX/etc/forgejo/app.ini"
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.AppWorkPath=$CLANDRO_PREFIX/var/lib/forgejo"
	LDFLAGS+=" -X forgejo.org/forgejo/modules/setting.CustomPath=$CLANDRO_PREFIX/var/lib/forgejo"
	FORGEJO_VERSION=v"$CLANDRO_PKG_VERSION" TAGS="bindata sqlite sqlite_unlock_notify" make all
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/forgejo.org/forgejo/gitea \
		"$CLANDRO_PREFIX"/bin/forgejo

	mkdir -p "$CLANDRO_PREFIX"/etc/forgejo
	sed "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/app.ini > "$CLANDRO_PREFIX"/etc/forgejo/app.ini
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/lib/forgejo
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/log/forgejo
}
