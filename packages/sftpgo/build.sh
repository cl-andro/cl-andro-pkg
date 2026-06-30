CLANDRO_PKG_HOMEPAGE=https://sftpgo.com/
CLANDRO_PKG_DESCRIPTION="Full-featured and highly configurable SFTP, HTTP/S, FTP/S and WebDAV server"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.1"
CLANDRO_PKG_SRCURL=https://github.com/drakkan/sftpgo/releases/download/v$CLANDRO_PKG_VERSION/sftpgo_v${CLANDRO_PKG_VERSION}_src_with_deps.tar.xz
CLANDRO_PKG_SHA256=64b2826af512eb8ce8cd880ce4b9a23897b45515130ea8cc4490fd70a80c812a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_HOSTBUILD=true

clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR" --strip-components=0
}

clandro_step_host_build() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"
	go build -mod vendor -o sftpgo
	mv sftpgo "$CLANDRO_PKG_HOSTBUILD_DIR"/sftpgo
}

clandro_step_make() {
	clandro_setup_golang

	local _commit="$(cat VERSION.txt | head -n 2 | tail -n 1)"
	local _go_ldflags="-s -w"
	_go_ldflags+=" -X github.com/drakkan/sftpgo/v2/internal/version.commit=${_commit}"
	_go_ldflags+=" -X github.com/drakkan/sftpgo/v2/internal/version.date=$(date -u +%FT%TZ)"

	go build -trimpath -ldflags "$_go_ldflags" -mod vendor -o sftpgo
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin sftpgo
	install -Dm600 -t "$CLANDRO_PREFIX"/etc/sftpgo sftpgo.json

	mkdir -p "$CLANDRO_PREFIX"/share/sftpgo/{templates,static,openapi}
	cp -Rf "$CLANDRO_PKG_SRCDIR"/templates/* "$CLANDRO_PREFIX"/share/sftpgo/templates
	cp -Rf "$CLANDRO_PKG_SRCDIR"/static/* "$CLANDRO_PREFIX"/share/sftpgo/static
	cp -Rf "$CLANDRO_PKG_SRCDIR"/openapi/* "$CLANDRO_PREFIX"/share/sftpgo/openapi

	mkdir -p "$CLANDRO_PREFIX"/share/bash-completion/completions
	"$CLANDRO_PKG_HOSTBUILD_DIR"/sftpgo gen completion bash > \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/sftpgo

	mkdir -p "$CLANDRO_PREFIX"/share/zsh/site-functions
	"$CLANDRO_PKG_HOSTBUILD_DIR"/sftpgo gen completion zsh > \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_sftpgo

	mkdir -p "$CLANDRO_PREFIX"/share/fish/vendor_completions.d
	"$CLANDRO_PKG_HOSTBUILD_DIR"/sftpgo gen completion fish > \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/sftpgo.fish

	mkdir -p "$CLANDRO_PREFIX"/share/sftpgo/man/man1
	"$CLANDRO_PKG_HOSTBUILD_DIR"/sftpgo gen man -d "$CLANDRO_PREFIX"/share/sftpgo/man/man1

	# for sftpgo.db
	mkdir -p "$CLANDRO_PREFIX"/var/lib/sftpgo
	touch "$CLANDRO_PREFIX"/var/lib/sftpgo/.placeholder
}
