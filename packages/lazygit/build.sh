CLANDRO_PKG_HOMEPAGE=https://github.com/jesseduffield/lazygit
CLANDRO_PKG_DESCRIPTION="Simple terminal UI for git commands"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="0.61.1"
CLANDRO_PKG_SRCURL=https://github.com/jesseduffield/lazygit/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2a550c9b609c5eb0e1c2640e8114ac05b94c671803f77e08a9dcdbd66372e2c4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RECOMMENDS=git
CLANDRO_PKG_SUGGESTS=diff-so-fancy

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/jesseduffield"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit"

	go build \
	-trimpath \
	-mod=readonly \
	-modcacherw \
	-ldflags "\
	-X main.date=$(date --date=@${SOURCE_DATE_EPOCH} -u +%Y-%m-%dT%H:%M:%SZ) \
	-X main.buildSource=termux \
	-X main.version=${CLANDRO_PKG_VERSION} \
	-X main.commit=v${CLANDRO_PKG_VERSION} \
	"
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/doc/lazygit

	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/lazygit \
		$CLANDRO_PREFIX/bin/lazygit

	cp -a ${CLANDRO_PKG_BUILDDIR}/src/github.com/jesseduffield/lazygit/docs/* \
		$CLANDRO_PREFIX/share/doc/lazygit/

}
