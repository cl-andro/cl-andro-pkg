clandro_step_create_debian_package() {
	if [ "$CLANDRO_PKG_METAPACKAGE" = "true" ]; then
		# Metapackage doesn't have data inside.
		rm -rf data
	fi
	tar --sort=name \
		--mtime="@${SOURCE_DATE_EPOCH}" \
		--owner=0 --group=0 --numeric-owner \
		-cJf "$CLANDRO_PKG_PACKAGEDIR/data.tar.xz" -H gnu .

	# Get install size. This will be written as the "Installed-Size" deb field so is measured in 1024-byte blocks:
	local CLANDRO_PKG_INSTALLSIZE
	CLANDRO_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)

	# From here on CLANDRO_ARCH is set to "all" if CLANDRO_PKG_PLATFORM_INDEPENDENT is set by the package
	[ "$CLANDRO_PKG_PLATFORM_INDEPENDENT" = "true" ] && CLANDRO_ARCH=all

	mkdir -p DEBIAN
	cat > DEBIAN/control <<-HERE
		Package: $CLANDRO_PKG_NAME
		Architecture: ${CLANDRO_ARCH}
		Installed-Size: ${CLANDRO_PKG_INSTALLSIZE}
		Maintainer: $CLANDRO_PKG_MAINTAINER
		Version: $CLANDRO_PKG_FULLVERSION
		Homepage: $CLANDRO_PKG_HOMEPAGE
	HERE
	if [ "$CLANDRO_GLOBAL_LIBRARY" = "true" ] && [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		test ! -z "$CLANDRO_PKG_DEPENDS" && CLANDRO_PKG_DEPENDS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_DEPENDS")
		test ! -z "$CLANDRO_PKG_BREAKS" && CLANDRO_PKG_BREAKS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_BREAKS")
		test ! -z "$CLANDRO_PKG_CONFLICTS" && CLANDRO_PKG_CONFLICTS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_CONFLICTS")
		test ! -z "$CLANDRO_PKG_RECOMMENDS" && CLANDRO_PKG_RECOMMENDS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_RECOMMENDS")
		test ! -z "$CLANDRO_PKG_REPLACES" && CLANDRO_PKG_REPLACES=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_REPLACES")
		test ! -z "$CLANDRO_PKG_PROVIDES" && CLANDRO_PKG_PROVIDES=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_PROVIDES")
		test ! -z "$CLANDRO_PKG_SUGGESTS" && CLANDRO_PKG_SUGGESTS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_PKG_SUGGESTS")
	fi
	test ! -z "$CLANDRO_PKG_BREAKS" && echo "Breaks: $CLANDRO_PKG_BREAKS" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_PRE_DEPENDS" && echo "Pre-Depends: $CLANDRO_PKG_PRE_DEPENDS" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_DEPENDS" && echo "Depends: $CLANDRO_PKG_DEPENDS" >> DEBIAN/control
	[ "$CLANDRO_PKG_ESSENTIAL" = "true" ] && echo "Essential: yes" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_CONFLICTS" && echo "Conflicts: $CLANDRO_PKG_CONFLICTS" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_RECOMMENDS" && echo "Recommends: $CLANDRO_PKG_RECOMMENDS" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_REPLACES" && echo "Replaces: $CLANDRO_PKG_REPLACES" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_PROVIDES" && echo "Provides: $CLANDRO_PKG_PROVIDES" >> DEBIAN/control
	test ! -z "$CLANDRO_PKG_SUGGESTS" && echo "Suggests: $CLANDRO_PKG_SUGGESTS" >> DEBIAN/control
	echo "Description: $CLANDRO_PKG_DESCRIPTION" >> DEBIAN/control

	# Create DEBIAN/conffiles (see https://www.debian.org/doc/debian-policy/ap-pkg-conffiles.html):
	for f in $CLANDRO_PKG_CONFFILES; do echo "$CLANDRO_PREFIX_CLASSICAL/$f" >> DEBIAN/conffiles; done

	# Allow packages to create arbitrary control files.
	# XXX: Should be done in a better way without a function?
	cd DEBIAN
	clandro_step_create_debscripts
	# Process `update-alternatives` entries from `.alternatives` files
	# These need to be merged into the `.postinst` and `.prerm` files, so after those are created.
	clandro_step_update_alternatives
	clandro_step_create_python_debscripts

	# Create control.tar.xz
	tar --sort=name \
		--mtime="@${SOURCE_DATE_EPOCH}" \
		--owner=0 --group=0 --numeric-owner \
		-cJf "$CLANDRO_PKG_PACKAGEDIR/control.tar.xz" -H gnu .

	test ! -f "$CLANDRO_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$CLANDRO_COMMON_CACHEDIR/debian-binary"
	CLANDRO_PKG_DEBFILE=$CLANDRO_OUTPUT_DIR/${CLANDRO_PKG_NAME}${DEBUG}_${CLANDRO_PKG_FULLVERSION}_${CLANDRO_ARCH}.deb
	# Create the actual .deb file:
	${AR-ar} cr "$CLANDRO_PKG_DEBFILE" \
		"$CLANDRO_COMMON_CACHEDIR/debian-binary" \
		"$CLANDRO_PKG_PACKAGEDIR/control.tar.xz" \
		"$CLANDRO_PKG_PACKAGEDIR/data.tar.xz"
}
