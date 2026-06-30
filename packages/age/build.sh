CLANDRO_PKG_HOMEPAGE=https://github.com/FiloSottile/age
CLANDRO_PKG_DESCRIPTION="A simple, modern and secure encryption tool with small explicit keys, no config options, and UNIX-style composability"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:1.3.1"
CLANDRO_PKG_SRCURL=https://github.com/FiloSottile/age/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SHA256=396007bc0bc53de253391493bda1252757ba63af1a19db86cfb60a35cb9d290a

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR
	go build ./cmd/age
	go build ./cmd/age-keygen
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin \
		"${CLANDRO_PKG_SRCDIR}"/age \
		"${CLANDRO_PKG_SRCDIR}"/age-keygen
}
