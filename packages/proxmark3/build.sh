# Contributor: @s00se
CLANDRO_PKG_HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"
CLANDRO_PKG_DESCRIPTION="The Swiss Army Knife of RFID Research - RRG/Iceman repo"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Marlin Sööse <marlin.soose@esque.ca>"
CLANDRO_PKG_VERSION="1:4.21611"
CLANDRO_PKG_SRCURL="https://github.com/RfidResearchGroup/proxmark3/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=e149802a10acb3358ad452f424f83527c00ee38fbb65d6400a4acd570d4aaef8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2, libc++, liblz4, readline, python"
CLANDRO_PKG_BUILD_IN_SRC="true"
CLANDRO_PKG_EXCLUDED_ARCHES="i686, x86_64"

clandro_step_post_configure() {
	export LDLIBS="$LDFLAGS"
	export INCLUDES="$CPPFLAGS"
	CLANDRO_PKG_EXTRA_MAKE_ARGS="client CC=$CC CXX=$CXX LD=$CXX cpu_arch=$CLANDRO_ARCH SKIPREVENGTEST=1 SKIPQT=1 SKIPPTHREAD=1 SKIPGD=1 PLATFORM=PM3GENERIC"
}

clandro_step_make_install() {
	install -Dm700 "$CLANDRO_PKG_BUILDDIR"/client/proxmark3 "$CLANDRO_PREFIX"/bin/proxmark3
	mkdir -p "$CLANDRO_PREFIX"/share/proxmark3/
	cp -R "$CLANDRO_PKG_BUILDDIR"/client/resources/ "$CLANDRO_PREFIX"/share/proxmark3/resources/
	cp -R "$CLANDRO_PKG_BUILDDIR"/client/dictionaries/ "$CLANDRO_PREFIX"/share/proxmark3/dictionaries/
	cp -R "$CLANDRO_PKG_BUILDDIR"/client/pyscripts/ "$CLANDRO_PREFIX"/share/proxmark3/pyscripts/
	cp -R "$CLANDRO_PKG_BUILDDIR"/client/luascripts/ "$CLANDRO_PREFIX"/share/proxmark3/luascripts/
	cp -R "$CLANDRO_PKG_BUILDDIR"/client/lualibs/ "$CLANDRO_PREFIX"/share/proxmark3/lualibs/
}
