CLANDRO_PKG_HOMEPAGE=https://cc65.github.io/
CLANDRO_PKG_DESCRIPTION="A free compiler for 6502 based system"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.19
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cc65/cc65/archive/refs/tags/V${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=157b8051aed7f534e5093471e734e7a95e509c577324099c3c81324ed9d0de77
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	cd $CLANDRO_PKG_SRCDIR
	make clean
	make
}

clandro_step_pre_configure() {
	# hostbuild step have to be run everytime currently
	rm -Rf $CLANDRO_PKG_HOSTBUILD_DIR
}

clandro_step_make() {
	make clean -C src
	make bin
}

clandro_pkg_auto_update() {
	local latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}" newest-tag)"
	[[ -z "${latest_tag}" ]] && clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	clandro_pkg_upgrade_version "${latest_tag#V}"
}
