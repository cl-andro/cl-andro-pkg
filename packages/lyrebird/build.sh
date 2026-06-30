CLANDRO_PKG_HOMEPAGE=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports
CLANDRO_PKG_DESCRIPTION="A pluggable transport plugin for Tor"
CLANDRO_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, GPL-3.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, LICENSE-GPL3.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_SRCURL=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird/-/archive/lyrebird-$CLANDRO_PKG_VERSION/lyrebird-lyrebird-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4486a6adcce20b78c3de4f5604d0c1500d049beca9ba322c1fd65813c79a30e2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="obfs4proxy"
CLANDRO_PKG_PROVIDES="obfs4proxy"
CLANDRO_PKG_REPLACES="obfs4proxy"

## lyrebird/obfs4proxy is a pluggable transport plugin for Tor, so
## marking "tor" package as dependency.
CLANDRO_PKG_DEPENDS="tor"

clandro_step_make() {
	clandro_setup_golang
	# it does not contain install target so it is useless
	rm Makefile
	cd "$CLANDRO_PKG_SRCDIR"/cmd/lyrebird
	go get -d ./cmd/...
	go build -ldflags="-X main.lyrebirdVersion=${CLANDRO_PKG_VERSION} -checklinkname=0" .
}

clandro_step_post_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}/bin/" "${CLANDRO_PKG_SRCDIR}/cmd/lyrebird/lyrebird"
	rm -f "${CLANDRO_PREFIX}/bin/obfs4proxy"
	ln -s "${CLANDRO_PREFIX}/bin/lyrebird" "${CLANDRO_PREFIX}/bin/obfs4proxy"
}
