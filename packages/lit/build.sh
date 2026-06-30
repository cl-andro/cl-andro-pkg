CLANDRO_PKG_HOMEPAGE=https://luvit.io
CLANDRO_PKG_DESCRIPTION="Toolkit for developing, sharing, and running luvit/lua programs and libraries."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.8.5
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=git+https://github.com/luvit/lit.git
CLANDRO_PKG_GIT_BRANCH=${CLANDRO_PKG_VERSION}
CLANDRO_PKG_DEPENDS="luvi"
CLANDRO_PKG_SUGGESTS="luvit"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STRIP=true

clandro_step_configure() {
	sh "${CLANDRO_PKG_SRCDIR}/get-lit.sh"
	mv lit "${CLANDRO_PKG_SRCDIR}/_lit"
}

clandro_step_make() {
	touch dummy
	./_lit make . ./lit dummy
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/lit"
	unzip -d "${CLANDRO_PREFIX}/share/lit" lit

	cat > "${CLANDRO_PREFIX}/bin/lit" <<-EOF
	#!${CLANDRO_PREFIX}/bin/env bash
	exec luvi ${CLANDRO_PREFIX}/share/lit -- \$@
	EOF
	chmod 700 "${CLANDRO_PREFIX}/bin/lit"
}
