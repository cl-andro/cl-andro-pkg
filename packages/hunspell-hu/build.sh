CLANDRO_PKG_HOMEPAGE=https://magyarispell.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Hungarian dictionary for hunspell"
CLANDRO_PKG_LICENSE="MPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2024.03.28
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_post_get_source() {
	clandro_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/README_hu_HU.txt \
			$CLANDRO_PKG_SRCDIR/README_hu_HU.txt \
			cd2c7ae61d509dbb6eb298b8185e3b0c1cc2ed1f39d9ef146efd05e28fd541dc
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/hu_HU/hu_HU.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/hu_HU/hu_HU.dic
	# In which case we need to bump version and checksum used.
	clandro_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/hu_HU.aff \
			$CLANDRO_PREFIX/share/hunspell/hu_HU.aff \
			7fbfe784398e6605cae9d75988187cd59e8cfa1040cc30783a55cd92d3b9ea41
	clandro_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/hu_HU/hu_HU.dic \
			$CLANDRO_PREFIX/share/hunspell/hu_HU.dic \
			2ec787f2992a8affe82a9aa912a0a881b21dfa6a61dc8a35aa160e5e41565bda
	touch $CLANDRO_PREFIX/share/hunspell/hu_HU.{aff,dic}

	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_SRCDIR/README_hu_HU.txt
}
