CLANDRO_PKG_HOMEPAGE=https://nuetzlich.net/gocryptfs/
CLANDRO_PKG_DESCRIPTION="An encrypted overlay filesystem written in Go"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.6.1+really2.5.4"
CLANDRO_PKG_SRCURL=https://github.com/rfjakob/gocryptfs/archive/refs/tags/v${CLANDRO_PKG_VERSION#*really}.tar.gz
CLANDRO_PKG_SHA256=bbdfb574ad08faed19b724022bc167b00236967c742b23c25f95f8c31837342c
CLANDRO_PKG_DEPENDS="openssl, libfuse2"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	local GITVERSIONFUSE=$(go list -m github.com/hanwen/go-fuse/v2 | cut -d' ' -f2-)
	local GO_LDFLAGS="-extldflags=-Wl,-rpath=$CLANDRO_PREFIX/lib"
	GO_LDFLAGS+=" -X \"main.GitVersion=v${CLANDRO_PKG_VERSION#*really}\""
	GO_LDFLAGS+=" -X \"main.GitVersionFuse=$GITVERSIONFUSE\""
	GO_LDFLAGS+=" -X \"main.BuildDate=$(date +%Y-%m-%d)\""
	go build -ldflags "$GO_LDFLAGS"
	go build -ldflags "$GO_LDFLAGS" \
		-o ./gocryptfs-xray/gocryptfs-xray ./gocryptfs-xray
	./Documentation/MANPAGE-render.bash
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./gocryptfs
	install -Dm700 -t $CLANDRO_PREFIX/bin ./gocryptfs-xray/gocryptfs-xray
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 \
		./Documentation/gocryptfs{,-xray}.1
}
