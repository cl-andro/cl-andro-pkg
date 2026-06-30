CLANDRO_PKG_HOMEPAGE=https://unicode.org/ucd/
CLANDRO_PKG_DESCRIPTION="The Unicode Character Database (UCD)"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="copyright.html"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="18.0.0"
CLANDRO_PKG_SRCURL=(
	https://unicode.org/Public/${CLANDRO_PKG_VERSION}/ucd/UCD.zip
	https://unicode.org/Public/${CLANDRO_PKG_VERSION}/ucd/Unihan.zip
)
CLANDRO_PKG_SHA256=(
	c961d4405edd144b5052cfaf8bf7db54af44ebc5db7181f83c6c52df99e9363a
	835593ec1ca206486cdef6860a41930343ac014d7d61f7f7ef2b25084fadbdd4
)
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology

clandro_step_get_source() {
	local i
	for i in $(seq 0 $(( ${#CLANDRO_PKG_SRCURL[@]}-1 ))); do
		local f="${CLANDRO_PKG_NAME}-$(basename "${CLANDRO_PKG_SRCURL[$i]}")"
		clandro_download \
			"${CLANDRO_PKG_SRCURL[$i]}" \
			"$CLANDRO_PKG_CACHEDIR/${f}" \
			"${CLANDRO_PKG_SHA256[$i]}"
	done
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	unzip -d "$CLANDRO_PKG_SRCDIR" \
		"$CLANDRO_PKG_CACHEDIR/${CLANDRO_PKG_NAME}-UCD.zip"
	cp "$CLANDRO_PKG_CACHEDIR/${CLANDRO_PKG_NAME}-Unihan.zip" \
		"$CLANDRO_PKG_SRCDIR/Unihan.zip"
}

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/copyright.html ./
}

clandro_step_make_install() {
	cp -rT "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PREFIX/share/${CLANDRO_PKG_NAME}"
}
