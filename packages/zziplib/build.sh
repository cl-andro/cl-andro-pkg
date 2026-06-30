CLANDRO_PKG_HOMEPAGE=https://zziplib.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Provides read access to zipped files in a zip-archive, using compression based on free algorithms"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.13.80"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/gdraheim/zziplib/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=21f40d111c0f7a398cfee3b0a30b20c5d92124b08ea4290055fbfe7bdd53a22c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DZZIPTEST=off -DZZIPDOCS=off"
CLANDRO_PKG_DEPENDS="zlib"

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/lib
	for lib in zzip zzipfseeko zzipmmapped zzipwrap; do
		ln -sf lib${lib}-0.so lib${lib}.so
	done
}
