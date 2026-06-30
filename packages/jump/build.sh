CLANDRO_PKG_HOMEPAGE=https://github.com/gsamokovarov/jump
CLANDRO_PKG_DESCRIPTION="Jump helps you navigate in shell faster by learning your habits"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.51.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/gsamokovarov/jump/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ce297cada71e1dca33cd7759e55b28518d2bf317cdced1f3b3f79f40fa1958b5

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR
	cd $CLANDRO_PKG_SRCDIR
	go build .
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin \
		"${CLANDRO_PKG_SRCDIR}"/jump
}
