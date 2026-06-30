CLANDRO_PKG_HOMEPAGE=https://github.com/dimkr/loksh
CLANDRO_PKG_DESCRIPTION="A Linux port of OpenBSD's ksh"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.8"
CLANDRO_PKG_SRCURL=git+https://github.com/dimkr/loksh
CLANDRO_PKG_GIT_BRANCH=$CLANDRO_PKG_VERSION
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"

clandro_step_post_get_source() {
	pushd subprojects/lolibc
	mv include _include_lolibc
	mkdir include
	mv _include_lolibc include/lolibc
	pushd include/lolibc
	local _LOLIBC_HEADERS=$(find * -name '*.h')
	popd
	popd
	local f
	for f in $(find . -name '*.[ch]'); do
		local h
		for h in ${_LOLIBC_HEADERS}; do
			sed -i "s:#include <${h//./\\.}>:#include <lolibc/${h}>:g" ${f}
		done
	done
	cd subprojects/lolibc/include/lolibc
	for f in ${_LOLIBC_HEADERS}; do
		sed -i "s:#include_next :#include :g" ${f}
	done

	CFLAGS+=" -D__USE_GNU"
}
