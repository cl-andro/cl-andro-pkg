CLANDRO_PKG_HOMEPAGE=https://luvit.io
CLANDRO_PKG_DESCRIPTION="Asynchronous I/O for Lua"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.18.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/luvit/luvit/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b792781d77028edb7e5761e96618c96162bd68747b8fced9a6fc52f123837c2c
CLANDRO_PKG_DEPENDS="luvi"
CLANDRO_PKG_SUGGESTS="lit"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STRIP=true

clandro_step_configure() {
	curl -Lo- https://github.com/luvit/lit/raw/"$(
		source "${CLANDRO_SCRIPTDIR}/packages/lit/build.sh"
		echo "${CLANDRO_PKG_VERSION}"
	)"/get-lit.sh | sh
	mv lit "${CLANDRO_PKG_SRCDIR}/_lit"
}

clandro_step_make() {
	touch dummy
	./_lit make . ./luvit dummy
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/luvit"
	unzip -d "${CLANDRO_PREFIX}/share/luvit" luvit

	cat > "${CLANDRO_PREFIX}/bin/luvit" <<-EOF
	#!${CLANDRO_PREFIX}/bin/env bash
	exec luvi ${CLANDRO_PREFIX}/share/luvit -- \$@
	EOF
	chmod 700 "${CLANDRO_PREFIX}/bin/luvit"
}
