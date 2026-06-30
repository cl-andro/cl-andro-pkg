CLANDRO_PKG_HOMEPAGE="https://freedesktop.org/wiki/Specifications/sound-theme-spec"
CLANDRO_PKG_DESCRIPTION="Freedesktop sound theme"
CLANDRO_PKG_LICENSE="GPL-2.0, GPL-2.0-or-later, custom" # and some CC-BY and CC-BY-SA
CLANDRO_PKG_LICENSE_FILE="CREDITS"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8"
CLANDRO_PKG_SRCURL="https://gitlab.freedesktop.org/xdg/xdg-sound-theme/-/archive/${CLANDRO_PKG_VERSION}/xdg-sound-theme-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="b3f611d15d9ee48d1dfaa98341d38f169939ed8b99d0b42f96d1d5d8a2d8498c"
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="intltool"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	autoreconf -fi
}
