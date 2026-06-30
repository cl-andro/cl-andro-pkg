CLANDRO_PKG_HOMEPAGE=https://algernon.roboticoverlords.org/
CLANDRO_PKG_DESCRIPTION="Small self-contained web server with Lua, Markdown, QUIC, Redis and PostgreSQL support"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17.6"
CLANDRO_PKG_SRCURL="https://github.com/xyproto/algernon/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=9e95d59c0d821e06b7193a115447bd16cd8bfa077538237a17bf508053ef15bb
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}"/src/github.com/xyproto
	ln -sf "${CLANDRO_PKG_SRCDIR}" "${GOPATH}"/src/github.com/xyproto/algernon

	cd "${GOPATH}"/src/github.com/xyproto/algernon || exit 1

	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"${GOPATH}"/src/github.com/xyproto/algernon/algernon \
		"${CLANDRO_PREFIX}"/bin/

	# Offline samples may be useful to get started with Algernon.
	rm -rf "${CLANDRO_PREFIX}"/share/doc/algernon
	mkdir -p "${CLANDRO_PREFIX}"/share/doc/algernon
	cp -a "${GOPATH}"/src/github.com/xyproto/algernon/samples \
		"${CLANDRO_PREFIX}"/share/doc/algernon/
}
