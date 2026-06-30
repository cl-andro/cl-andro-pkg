CLANDRO_PKG_HOMEPAGE=http://www.brow.sh/
CLANDRO_PKG_DESCRIPTION="A fully-modern text-based browser, rendering to TTY and browsers"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.8.3
CLANDRO_PKG_SRCURL=(
	"https://github.com/browsh-org/browsh/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
	"https://github.com/browsh-org/browsh/releases/download/v$CLANDRO_PKG_VERSION/browsh-$CLANDRO_PKG_VERSION.xpi"
)
CLANDRO_PKG_SHA256=(
	88462530dbfac4e17c8f8ba560802d21042d90236043e11461a1cfbf458380ca
	c0b72d7c61c30a0cb79cc1bf9dcf3cdaa3631ce029f1578e65c116243ed04e16
)
CLANDRO_PKG_DEPENDS="firefox"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="firefox"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

clandro_extract_src_archive() {
	# The default version of the tarball extraction function chokes on the .xpi file
	local tarball extension
	tarball="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL[0]}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar -xf "$tarball" -C "$CLANDRO_PKG_SRCDIR" --strip-components=1

	extension="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL[1]}")"
	cp -f "$extension" "$CLANDRO_PKG_SRCDIR/interfacer/src/browsh/browsh.xpi"
}

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR/interfacer" && \
	go build -x -modcacherw -o ./bin/browsh ./cmd/browsh
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" ./interfacer/bin/browsh
}
