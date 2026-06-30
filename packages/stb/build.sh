CLANDRO_PKG_HOMEPAGE=https://github.com/nothings/stb
CLANDRO_PKG_DESCRIPTION="Single-file public domain (or MIT licensed) libraries for C/C++"
CLANDRO_PKG_LICENSE="Public Domain, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.0+g31c1ad37"
CLANDRO_PKG_SRCURL="https://github.com/nothings/stb/archive/${CLANDRO_PKG_VERSION##*+g}.tar.gz"
CLANDRO_PKG_SHA256=e4e3bba9c572a4a4148373a914d88ea0f0d11de8cc2c66739926e7eca0223319
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm 644 *.{c,h} -t "${CLANDRO__PREFIX__INCLUDE_DIR}"/stb/
}
