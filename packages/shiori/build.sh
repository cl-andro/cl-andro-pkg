CLANDRO_PKG_HOMEPAGE=https://github.com/go-shiori/shiori
CLANDRO_PKG_DESCRIPTION="Simple bookmark manager built with Go"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="1.8.0"
CLANDRO_PKG_SRCURL=https://github.com/go-shiori/shiori/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e172010728b5d8142100a402b5b2d065471920b6bcc1b742ba9755f3be26ff2e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/go-shiori/
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/go-shiori/shiori
	cd "$GOPATH"/src/github.com/go-shiori/shiori/
	go get -d -v

	# https://github.com/termux/termux-packages/issues/18395
	# https://gitlab.com/cznic/libc/-/blob/master/libc_linux.go
	if [[ "${CLANDRO_ARCH_BITS}" == "32" ]]; then
		local libc_version=$(grep modernc.org/libc go.mod | awk '{print $2}')
		go mod edit -replace "modernc.org/libc@${libc_version}=./libc"
		rm -fr libc
		cp --no-preserve=mode,ownership -fr "${GOPATH}/pkg/mod/modernc.org/libc@${libc_version}" libc
		sed -e "s|unix.SYS_GETEUID|unix.SYS_GETEUID32|" -i ./libc/libc_linux.go
	fi

	go build
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$GOPATH"/src/github.com/go-shiori/shiori/shiori
	mkdir -p "${CLANDRO_PREFIX}"/share/doc/shiori
	cp -a "$CLANDRO_PKG_SRCDIR"/docs/ "$CLANDRO_PREFIX"/share/doc/shiori
}
