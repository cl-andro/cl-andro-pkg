CLANDRO_PKG_HOMEPAGE=https://github.com/danmar/cppcheck
CLANDRO_PKG_DESCRIPTION="tool for static C/C++ code analysis"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.20.1"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology # Upstream only releases major versions theough GitHub. Other minor updates are released using git tags, better rely on repology for updated versiom
CLANDRO_PKG_SRCURL=https://github.com/danmar/cppcheck/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=97634b598b8adf23e6cbd75aec5a8ac2d8b5f49f53e6a145b1c8380525c48a91
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libc++"

# Prevent running dmake during builds. dmake just generates Makefile which we
# aren't using, and QT translation files, but as we are not building the GUI,
# there is no need.  And anyways will lead to "Exec format" error as running
# target binaries on host
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DUSE_MATCHCOMPILER=On -DDISABLE_DMAKE=ON"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
