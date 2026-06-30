CLANDRO_PKG_HOMEPAGE=https://github.com/mvdan/fdroidcl
CLANDRO_PKG_DESCRIPTION="F-Droid client"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mvdan/fdroidcl/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=934881b18ce13a7deb246321678eabd3f81284cae61ff4d18bde6c7c4217584a
CLANDRO_PKG_DEPENDS="android-tools"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/mvdan.cc
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/mvdan.cc/fdroidcl
	cd "$GOPATH"/src/mvdan.cc/fdroidcl

	go build .
}

clandro_step_make_install() {
	install -Dm700 "$CLANDRO_PKG_BUILDDIR"/src/mvdan.cc/fdroidcl/fdroidcl \
		"$CLANDRO_PREFIX"/bin/fdroidcl
}
