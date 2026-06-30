CLANDRO_PKG_HOMEPAGE=https://github.com/ProtonMail/proton-bridge
CLANDRO_PKG_DESCRIPTION="ProtonMail Bridge application"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_VERSION="3.24.2"
CLANDRO_PKG_SRCURL=git+https://github.com/ProtonMail/proton-bridge
CLANDRO_PKG_GIT_BRANCH="v${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_DEPENDS="glib, libsecret"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
# The go-rfc5322 module cannot currently be compiled for 32-bit OSes:
# https://github.com/ProtonMail/proton-bridge/blob/v2.1.1/BUILDS.md#prerequisites
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_make() {
	clandro_setup_golang
	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	cd "${CLANDRO_PKG_SRCDIR}" || exit 1

	rm -rf internal/fido \
			internal/frontend/grpc/fido.go

	make build-nogui
}

clandro_step_make_install() {
	install -Dm700 "${CLANDRO_PKG_SRCDIR}"/bridge "${CLANDRO_PREFIX}"/bin/proton-bridge
}
