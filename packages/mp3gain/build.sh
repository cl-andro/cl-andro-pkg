CLANDRO_PKG_HOMEPAGE=https://mp3gain.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Analyzes and adjusts mp3 files so that they have the same volume"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/mp3gain/mp3gain-${CLANDRO_PKG_VERSION//./_}-src.zip
CLANDRO_PKG_SHA256=5cc04732ef32850d5878b28fbd8b85798d979a025990654aceeaa379bcc9596d
CLANDRO_PKG_DEPENDS="libmpg123"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_extract_src_archive() {
	rm -Rf mp3gain
	mkdir mp3gain
	pushd mp3gain
	unzip -q "$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	popd
	mv mp3gain "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin mp3gain
}
