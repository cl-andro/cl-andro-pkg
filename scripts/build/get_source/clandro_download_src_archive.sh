clandro_download_src_archive() {
	local PKG_SRCURL=(${CLANDRO_PKG_SRCURL[@]})
	local PKG_SHA256=(${CLANDRO_PKG_SHA256[@]})
	if  [ ! ${#PKG_SRCURL[@]} == ${#PKG_SHA256[@]} ] && [ ! ${#PKG_SHA256[@]} == 0 ]; then
		clandro_error_exit "length of CLANDRO_PKG_SRCURL isn't equal to length of CLANDRO_PKG_SHA256."
	fi

	for i in $(seq 0 $(( ${#PKG_SRCURL[@]}-1 ))); do
		local file="$CLANDRO_PKG_CACHEDIR/$(basename "${PKG_SRCURL[$i]}")"
		if [ "${PKG_SHA256[$i]:-}" == "" ]; then
			clandro_download "${PKG_SRCURL[$i]}" "$file"
		else
			clandro_download "${PKG_SRCURL[$i]}" "$file" "${PKG_SHA256[$i]}"
		fi
	done
}
