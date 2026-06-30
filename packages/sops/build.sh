CLANDRO_PKG_HOMEPAGE=https://github.com/getsops/sops
CLANDRO_PKG_DESCRIPTION="Simple and flexible tool for managing secrets"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.13.0"
CLANDRO_PKG_SRCURL=https://github.com/getsops/sops/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b010a00f4e08e3a3fe23f70fe3958a8108de8b5d2478388e1fd7e0315e14f2ea
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

clandro_step_make_install() {
	clandro_setup_golang

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/getsops"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/getsops/sops"
	cd "${GOPATH}/src/github.com/getsops/sops" || return 9
	go get -d -v

	make install

	install -Dm700 "${GOPATH}/bin/"*/sops "${CLANDRO_PREFIX}/bin/sops"
}
