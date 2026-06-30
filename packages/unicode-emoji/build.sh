CLANDRO_PKG_HOMEPAGE=https://unicode.org/emoji/
CLANDRO_PKG_DESCRIPTION="Unicode Emoji Data Files"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="copyright.html"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="17.0.0"
CLANDRO_PKG_SRCURL=(
	https://www.unicode.org/Public/$CLANDRO_PKG_VERSION/emoji/emoji-sequences.txt
	https://www.unicode.org/Public/$CLANDRO_PKG_VERSION/emoji/emoji-test.txt
	https://www.unicode.org/Public/$CLANDRO_PKG_VERSION/emoji/emoji-zwj-sequences.txt
)
CLANDRO_PKG_SHA256=(
	12cc8267dc33cbd11ed32bcf6fc5dc2ad9c7a77bae1bdfba2f41b1b9b3ead8dd
	1d8a944f88d7952f7ef7c5167fef3c67995bcae24543949710231b03a201acda
	5b25441daed2322b068c5e70cda522946a4f0274df864445a1965a92e5fc5cad
)
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_get_source() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	local i
	for i in $(seq 0 $(( ${#CLANDRO_PKG_SRCURL[@]}-1 ))); do
		local bn="$(basename "${CLANDRO_PKG_SRCURL[$i]}")"
		local f="${CLANDRO_PKG_VERSION}-${bn}"
		clandro_download \
			"${CLANDRO_PKG_SRCURL[$i]}" \
			"$CLANDRO_PKG_CACHEDIR/${f}" \
			"${CLANDRO_PKG_SHA256[$i]}"
		cp "$CLANDRO_PKG_CACHEDIR/${f}" "$CLANDRO_PKG_SRCDIR/${bn}"
	done
}

clandro_step_post_get_source() {
	cp "$CLANDRO_PKG_BUILDER_DIR"/copyright.html ./
}

clandro_step_make_install() {
	local f
	for f in sequences test zwj-sequences; do
		install -Dm644 "$CLANDRO_PKG_SRCDIR/emoji-$f.txt" "$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME/emoji-$f.txt"
	done
}
