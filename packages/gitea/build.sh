CLANDRO_PKG_HOMEPAGE=https://gitea.io
CLANDRO_PKG_DESCRIPTION="Git with a cup of tea, painless self-hosted git service"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.25.5"
CLANDRO_PKG_SRCURL=https://github.com/go-gitea/gitea/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=b4f3cd4ed0ff3e6a272702690b94a9415b8ff0a1d2fbf365a1bb5c8cedcab458
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dash, git"
CLANDRO_PKG_CONFFILES="etc/gitea/app.ini"

clandro_step_pre_configure() {
	clandro_setup_nodejs
	clandro_setup_golang
}

clandro_step_make() {
	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/code.gitea.io
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/code.gitea.io/gitea

	(cd "$CLANDRO_PKG_SRCDIR" && npm install pnpm)
	export PATH="$CLANDRO_PKG_SRCDIR/node_modules/.bin:$PATH"

	cd "$GOPATH"/src/code.gitea.io/gitea

	go mod init || :
	go mod tidy

	# Effectively a backport of https://github.com/lib/pq/commit/6a102c04ac8dc082f1684b0488275575c374cb4c.
	for f in "$GOPATH"/pkg/mod/github.com/lib/pq@*/user_posix.go; do
		chmod 0755 "$(dirname "$f")"
		chmod 0644 "$f"
		sed -i '/^\/\/ +build /s/ linux / linux,!android /g' "$f"
	done

	LDFLAGS=""
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomConf=$CLANDRO_PREFIX/etc/gitea/app.ini"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.AppWorkPath=$CLANDRO_PREFIX/var/lib/gitea"
	LDFLAGS+=" -X code.gitea.io/gitea/modules/setting.CustomPath=$CLANDRO_PREFIX/var/lib/gitea"
	GITEA_VERSION=v"$CLANDRO_PKG_VERSION" TAGS="bindata sqlite sqlite_unlock_notify" make all
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/code.gitea.io/gitea/gitea \
		"$CLANDRO_PREFIX"/bin/gitea

	mkdir -p "$CLANDRO_PREFIX"/etc/gitea
	sed "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/app.ini > "$CLANDRO_PREFIX"/etc/gitea/app.ini
}

clandro_step_post_massage() {
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/lib/gitea
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX"/var/log/gitea
}
