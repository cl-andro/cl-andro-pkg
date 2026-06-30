CLANDRO_PKG_HOMEPAGE=https://syncthing.net/
CLANDRO_PKG_DESCRIPTION="Decentralized file synchronization"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# NOTE: as of 1.12.0 compilation fails when package zstd is
# present in CLANDRO_PREFIX.
CLANDRO_PKG_VERSION="2.0.16"
CLANDRO_PKG_SRCURL=https://github.com/syncthing/syncthing/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=30ab1917025de0d057ae53b3568e721bbea652b4b3d7bd96b04a6ef9bfb28bab
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	# The build.sh script doesn't with our compiler
	# so small adjustments to file locations are needed
	# so the build.go is fine.
	mkdir -p go/src/github.com/syncthing
	ln -sf "${CLANDRO_PKG_SRCDIR}" go/src/github.com/syncthing/syncthing

	# Set gopath so dependencies are built as in go get etc.
	export GOPATH="$(pwd)/go"

	cd go/src/github.com/syncthing/syncthing

	# Unset GOARCH so building build.go works.
	export GO_ARCH="${GOARCH}"
	export _CC="${CC}"
	export GO_OS="${GOOS}"
	unset GOOS GOARCH CGO_LDFLAGS CC

	# -checklinkname=0 for https://github.com/wlynxg/anet?tab=readme-ov-file#how-to-build-with-go-1230-or-later
	export EXTRA_LDFLAGS="-checklinkname=0"

	rm -rf vendor # syncthing has vendored dependencies, which fails with our compiler.
	# Now file structure is same as go get etc.
	go run build.go -goos "${GO_OS}" -goarch "${GO_ARCH}" \
		-cc "${_CC}" -version "v${CLANDRO_PKG_VERSION}" -no-upgrade build
}

clandro_step_make_install() {
	cp "${GOPATH}"/src/github.com/syncthing/syncthing/syncthing $CLANDRO_PREFIX/bin/

	for section in 1 5 7; do
		local MANDIR=$CLANDRO_PREFIX/share/man/man$section
		mkdir -p $MANDIR
		cp $CLANDRO_PKG_SRCDIR/man/*.$section $MANDIR
	done
}
