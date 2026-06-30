CLANDRO_PKG_HOMEPAGE=https://i2pd.website/
CLANDRO_PKG_DESCRIPTION="A full-featured C++ implementation of the I2P router"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.60.0"
CLANDRO_PKG_SRCURL="https://github.com/PurpleI2P/i2pd/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=ef32100c5ffdf4d23dfe78a2f6c08f65574fd79f992eb2ac8cfea0b6440deabd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, libc++, miniupnpc, openssl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_UPNP:BOOL=ON"
CLANDRO_PKG_RM_AFTER_INSTALL="src"

CLANDRO_PKG_CONFFILES="
etc/i2pd/i2pd.conf
etc/i2pd/tunnels.conf
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/build"
	CXXFLAGS="${CXXFLAGS/-Oz/-O2}"
}

clandro_step_post_make_install() {
	cd $CLANDRO_PKG_SRCDIR/../

	install -Dm600 -t "$CLANDRO_PREFIX"/etc/i2pd \
		./contrib/i2pd.conf \
		./contrib/tunnels.conf

	local _file _dir
	while read -r -d '' _file; do
		_dir="${_file#contrib/certificates}"
		_dir="${_dir%/*}"
		install -Dm600 "$_file" -t "${CLANDRO_PREFIX}/share/i2pd/certificates/${_dir}"
	done < <(find contrib/certificates -type f -print0)

	install -Dm600 -t "${CLANDRO_PREFIX}"/share/doc/i2pd/tunnels.d \
		./contrib/tunnels.d/README \
		./contrib/tunnels.d/IRC-Ilita.conf \
		./contrib/tunnels.d/IRC-Irc2P.conf

	install -Dm600 -t "${CLANDRO_PREFIX}"/share/man/man1 ./debian/i2pd.1
}
