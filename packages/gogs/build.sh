CLANDRO_PKG_HOMEPAGE=https://gogs.io
CLANDRO_PKG_DESCRIPTION="A painless self-hosted Git service"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.14.2"
CLANDRO_PKG_SRCURL=https://github.com/gogs/gogs/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fa16a396956edcfeb6a5a54e0de2c0837c9381ed49fb49ea2f40e9bc79ce9eb1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dash, git"
CLANDRO_PKG_CONFFILES="etc/gogs/app.ini"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_HOSTBUILD_DIR
	mkdir -p $CLANDRO_PKG_HOSTBUILD_DIR
	cd $CLANDRO_PKG_HOSTBUILD_DIR
	go install github.com/kevinburke/go-bindata/go-bindata@v3.24.0
}

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/gogs.io
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/gogs.io/gogs
	cd "$GOPATH"/src/gogs.io/gogs

	LDFLAGS=""
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomConf=$CLANDRO_PREFIX/etc/gogs/app.ini"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.AppWorkPath=$CLANDRO_PREFIX/var/lib/gogs"
	LDFLAGS+=" -X gogs.io/gogs/internal/conf.CustomPath=$CLANDRO_PREFIX/var/lib/gogs"

	PATH=$PATH:$CLANDRO_PKG_HOSTBUILD_DIR/bin go build -ldflags "${LDFLAGS}" -tags "bindata sqlite" -trimpath -o gogs
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/gogs.io/gogs/gogs \
		"$CLANDRO_PREFIX"/bin/gogs

	mkdir -p "$CLANDRO_PREFIX"/etc/gogs
	sed "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/app.ini > "$CLANDRO_PREFIX"/etc/gogs/app.ini
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/lib/gogs
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/log/gogs
}
