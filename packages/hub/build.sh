CLANDRO_PKG_HOMEPAGE=https://hub.github.com/
CLANDRO_PKG_DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.14.2
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/github/hub/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="git"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"

	cd "${GOPATH}/src/github.com/github/hub"
	make man-pages
}

clandro_step_pre_configure() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"
}

clandro_step_make() {
	cd "${GOPATH}/src/github.com/github/hub"
	make bin/hub "prefix=$CLANDRO_PREFIX"
}

clandro_step_make_install() {
	cd "${GOPATH}/src/github.com/github/hub"
	install -Dm700 ./bin/hub "$CLANDRO_PREFIX"/bin/hub

	install -D -m 600 -t "$CLANDRO_PREFIX"/share/man/man1 \
		"$CLANDRO_PKG_HOSTBUILD_DIR"/gopath/src/github.com/github/hub/share/man/man1/*.1
}
