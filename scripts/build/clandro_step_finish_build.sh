clandro_step_finish_build() {
	echo "clandro - build of '$CLANDRO_PKG_NAME' done"
	test -t 1 && printf "\033]0;%s - DONE\007" "$CLANDRO_PKG_NAME"

	mkdir -p "$CLANDRO_BUILT_PACKAGES_DIRECTORY"
	echo "$CLANDRO_PKG_FULLVERSION" > "$CLANDRO_BUILT_PACKAGES_DIRECTORY/$CLANDRO_PKG_NAME"

	for subpackage in "$CLANDRO_PKG_BUILDER_DIR"/*.subpackage.sh; do
		local subpkg_name="$(basename $subpackage | sed 's@\.subpackage\.sh@@g')"
		echo "$CLANDRO_PKG_FULLVERSION" > "$CLANDRO_BUILT_PACKAGES_DIRECTORY/${subpkg_name}"
	done
	exit 0
}
