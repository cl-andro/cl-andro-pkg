CLANDRO_PKG_HOMEPAGE=https://github.com/sass/libsass
CLANDRO_PKG_DESCRIPTION="Sass compiler written in C++"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.6.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sass/libsass/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=11f0bb3709a4f20285507419d7618f3877a425c0131ea8df40fe6196129df15d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	autoreconf -fi

	if [ "${CLANDRO_PKG_SRCURL:0:4}" != "git+" ] && [ ! -e VERSION ]; then
		echo "${CLANDRO_PKG_VERSION#*:}" > VERSION
	fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
