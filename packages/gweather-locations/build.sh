CLANDRO_PKG_HOMEPAGE="https://gitlab.gnome.org/GNOME/gweather-locations"
CLANDRO_PKG_DESCRIPTION="The GWeather locations database"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.2"
# https://download.gnome.org/sources/gweather-locations/${CLANDRO_PKG_VERSION%.*}/gweather-locations-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gweather-locations/-/archive/${CLANDRO_PKG_VERSION}/gweather-locations-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b1c30d19279e8603ac1405f033ad4cd49d84e30828facfb73b77064aff088e15
CLANDRO_PKG_BUILD_DEPENDS="gettext"
CLANDRO_PKG_AUTO_UPDATE=true
