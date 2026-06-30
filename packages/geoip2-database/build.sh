CLANDRO_PKG_HOMEPAGE=https://dev.maxmind.com/geoip/geoip2/geolite2/
CLANDRO_PKG_DESCRIPTION="GeoLite2 IP geolocation databases compiled by MaxMind"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

# MaxMind removed databases from public access:
# https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/
# Reusing files from the our last build (2019.12.21).
CLANDRO_PKG_VERSION=20191221
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/termux/distfiles/releases/download/2021.01.04/geolite2-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=7afd73d90325d4a8aa3707c0c4a34f89a4b469fe43b4f3a3d69da23884af1e70

clandro_step_make_install() {
	install -Dm600 \
		-t "$CLANDRO_PREFIX"/share/GeoIP/ \
		"${CLANDRO_PKG_SRCDIR}"/GeoLite2-{ASN,Country,City}.mmdb
}
