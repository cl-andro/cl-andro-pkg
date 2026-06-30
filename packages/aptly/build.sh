CLANDRO_PKG_HOMEPAGE=https://www.aptly.info
CLANDRO_PKG_DESCRIPTION="A Swiss Army knife for Debian repository management"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/aptly-dev/aptly/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=cadfabda2a59f397adfe6f9ce3c9ddc6fe4c6052f0e03a300ba1f22d7cf0e09a
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/github.com/aptly-dev/
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/aptly-dev/aptly
	cd "$GOPATH"/src/github.com/aptly-dev/aptly

	go mod tidy
	go mod vendor
	go generate
	go build -ldflags "-s -w" -trimpath -o build/aptly
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/aptly-dev/aptly/build/aptly \
		"$CLANDRO_PREFIX"/bin/aptly

	install -Dm600 \
		"$CLANDRO_PKG_SRCDIR"/man/aptly.1 \
		"$CLANDRO_PREFIX"/share/man/man1/aptly.1

	install -Dm600 \
		"$CLANDRO_PKG_SRCDIR"/completion.d/aptly \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/aptly

	install -Dm600 \
		"$CLANDRO_PKG_SRCDIR"/completion.d/_aptly \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_aptly
}
