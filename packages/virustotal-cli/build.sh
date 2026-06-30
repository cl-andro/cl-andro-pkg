CLANDRO_PKG_HOMEPAGE=https://github.com/VirusTotal/vt-cli
CLANDRO_PKG_DESCRIPTION="Command line interface for VirusTotal"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_SRCURL=https://github.com/VirusTotal/vt-cli/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=10a6edbbb7c81e6978ac55f65544b916906c9400d596beb2fe54f1093a3f7f98
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="vt-cli"
CLANDRO_PKG_REPLACES="vt-cli"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/VirusTotal
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/VirusTotal/vt-cli

	cd "$GOPATH"/src/github.com/VirusTotal/vt-cli

	go build \
		-ldflags "-X github.com/VirusTotal/vt-cli/cmd.Version=$CLANDRO_PKG_VERSION" \
		-o "$CLANDRO_PREFIX"/bin/vt-cli \
		./vt/main.go
}

clandro_step_make_install() {
	ln -sfr "$CLANDRO_PREFIX"/bin/vt-cli "$CLANDRO_PREFIX"/bin/vt
}
