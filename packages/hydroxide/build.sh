CLANDRO_PKG_HOMEPAGE=https://github.com/emersion/hydroxide
CLANDRO_PKG_DESCRIPTION="A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.31"
CLANDRO_PKG_SRCURL=https://github.com/emersion/hydroxide/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b4948ba32a3bebca1857b78aabd356a261d1f34b72ab0b36b11e2ce03a748184
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR
	go build ./cmd/hydroxide
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin "${CLANDRO_PKG_SRCDIR}"/hydroxide
}
