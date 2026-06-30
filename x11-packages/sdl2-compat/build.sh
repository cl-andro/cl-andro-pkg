CLANDRO_PKG_HOMEPAGE=https://www.libsdl.org
CLANDRO_PKG_DESCRIPTION="Simple DirectMedia Layer (SDL) sdl2-compat"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.32.68"
CLANDRO_PKG_SRCURL="https://github.com/libsdl-org/sdl2-compat/releases/download/release-${CLANDRO_PKG_VERSION}/sdl2-compat-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=401a64f5d0948f0d1a217cfdba4e72ce63d22f7a9fc3751251e0e3a175ff7703
CLANDRO_PKG_DEPENDS="sdl3"
CLANDRO_PKG_BREAKS="sdl2, sdl2-static"
CLANDRO_PKG_REPLACES="sdl2, sdl2-static"
CLANDRO_PKG_PROVIDES="sdl2, sdl2-static"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DSDL2COMPAT_TESTS=OFF
"

clandro_step_pre_configure() {
	cp -fr "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_TMPDIR}/a"
	find "${CLANDRO_PKG_SRCDIR}" -type f -print0 | xargs -0r -n1 sed -i \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)\(__[^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)__$/\1_NO_TERMUX__/g'
	cp -fr "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_TMPDIR}/b"
	echo "INFO: Modified files:"
	diff -uNr "${CLANDRO_PKG_TMPDIR}"/{a,b} --color || :
}
