CLANDRO_PKG_HOMEPAGE=https://restic.net/
CLANDRO_PKG_DESCRIPTION="Fast, secure, efficient backup program"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.18.1"
CLANDRO_PKG_SRCURL=https://github.com/restic/restic/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4b8e2b6cb20e9707e14b9b9d92ddb6f2e913523754e1f123e2e6f3321e67f7ca
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SUGGESTS="openssh, rclone, restic-server"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/restic

	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/restic/restic
	cd "$GOPATH"/src/github.com/restic/restic

	(
		# Separately building for host so we can generate manpages.
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go build -ldflags "-X 'main.version=${CLANDRO_PKG_VERSION}'" ./cmd/...
		./restic generate --man doc/man
		rm -f ./restic
	)

	go build -ldflags "-X 'main.version=${CLANDRO_PKG_VERSION}'" ./cmd/...
}

clandro_step_make_install() {
	cd "$GOPATH"/src/github.com/restic/restic
	install -Dm700 restic "$CLANDRO_PREFIX"/bin/restic
	install -Dm600 -t "$CLANDRO_PREFIX/share/man/man1/" doc/man/*.1
}
