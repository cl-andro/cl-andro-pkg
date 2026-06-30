clandro_create_debian_subpackages() {
	# Sub packages:
	local _ADD_PREFIX=""
	if [[ "$CLANDRO_PACKAGE_LIBRARY" == 'glibc' ]]; then
		_ADD_PREFIX="glibc/"
	fi
	if [[ "$CLANDRO_PKG_NO_STATICSPLIT" == 'false' && -n "$(shopt -s globstar; shopt -s nullglob; echo ${_ADD_PREFIX}lib{,32}/**/*.a)" ]]; then
		# Add virtual -static sub package if there are include files:
		local _STATIC_SUBPACKAGE_FILE=$CLANDRO_PKG_TMPDIR/${CLANDRO_PKG_NAME}-static.subpackage.sh
		echo CLANDRO_SUBPKG_INCLUDE=\"$(find ${_ADD_PREFIX}lib{,32} -name '*.a' -o -name '*.la' 2> /dev/null) $CLANDRO_PKG_STATICSPLIT_EXTRA_PATTERNS\" > "$_STATIC_SUBPACKAGE_FILE"
		echo "CLANDRO_SUBPKG_DESCRIPTION=\"Static libraries for ${CLANDRO_PKG_NAME}\"" >> "$_STATIC_SUBPACKAGE_FILE"
	fi

	# Now build all sub packages
	rm -Rf "$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/subpackages"
	for subpackage in $CLANDRO_PKG_BUILDER_DIR/*.subpackage.sh $CLANDRO_PKG_TMPDIR/*subpackage.sh; do
		[[ -f "$subpackage" ]] || continue
		local SUB_PKG_NAME
		SUB_PKG_NAME=$(basename "$subpackage" .subpackage.sh)
		if [[ "$CLANDRO_PACKAGE_LIBRARY" == 'glibc' ]] && ! clandro_package__is_package_name_have_glibc_prefix "$SUB_PKG_NAME"; then
			SUB_PKG_NAME="$(clandro_package__add_prefix_glibc_to_package_name ${SUB_PKG_NAME})"
		fi
		# Default value is same as main package, but sub package may override:
		local CLANDRO_SUBPKG_PLATFORM_INDEPENDENT=$CLANDRO_PKG_PLATFORM_INDEPENDENT
		local SUB_PKG_DIR=$CLANDRO_TOPDIR/$CLANDRO_PKG_NAME/subpackages/$SUB_PKG_NAME
		local CLANDRO_SUBPKG_ESSENTIAL=false
		local CLANDRO_SUBPKG_BREAKS=""
		local CLANDRO_SUBPKG_DEPENDS=""
		local CLANDRO_SUBPKG_RECOMMENDS=""
		local CLANDRO_SUBPKG_SUGGESTS=""
		local CLANDRO_SUBPKG_CONFLICTS=""
		local CLANDRO_SUBPKG_REPLACES=""
		local CLANDRO_SUBPKG_PROVIDES=""
		local CLANDRO_SUBPKG_CONFFILES=""
		local CLANDRO_SUBPKG_DEPEND_ON_PARENT=""
		local CLANDRO_SUBPKG_EXCLUDED_ARCHES=""
		local CLANDRO_SUBPKG_PYTHON_RUNTIME_DEPS=""
		local SUB_PKG_MASSAGE_DIR=$SUB_PKG_DIR/massage/$CLANDRO_PREFIX_CLASSICAL
		local SUB_PKG_PACKAGE_DIR=$SUB_PKG_DIR/package
		mkdir -p "$SUB_PKG_MASSAGE_DIR" "$SUB_PKG_PACKAGE_DIR"

		# Override clandro_step_create_subpkg_debscripts
		# shellcheck source=/dev/null
		source "$CLANDRO_SCRIPTDIR/scripts/build/clandro_step_create_subpkg_debscripts.sh"

		# shellcheck source=/dev/null
		source "$subpackage"

		# Do not create subpackage for specific arches.
		# Using CLANDRO_ARCH instead of SUB_PKG_ARCH (defined below) is intentional.
		if [[ " ${CLANDRO_SUBPKG_EXCLUDED_ARCHES//,/ } " == *" ${CLANDRO_ARCH} "* ]]; then
			echo "Skipping creating subpackage '$SUB_PKG_NAME' for arch $CLANDRO_ARCH"
			continue
		fi

		# Allow globstar (i.e. './**/') patterns.
		shopt -s globstar
		# Allow negation patterns.
		shopt -s extglob
		for includeset in $CLANDRO_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			[[ "$_INCLUDE_DIRSET" == "." ]] && _INCLUDE_DIRSET=""

			if [[ -e "$includeset" || -L "$includeset" ]]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			else
				echo "WARNING: tried to add $includeset to subpackage '$SUB_PKG_NAME', but could not find it"
			fi
		done
		shopt -u globstar extglob

		local SUB_PKG_ARCH=$CLANDRO_ARCH
		[[ "$CLANDRO_SUBPKG_PLATFORM_INDEPENDENT" == "true" ]] && SUB_PKG_ARCH=all

		cd "$SUB_PKG_DIR/massage"
		# Check that files were actually installed, else don't subpackage.
		if [[ "$SUB_PKG_ARCH" == "all" && "$(find . -type f -print | head -n1)" == "" ]]; then
			echo "No files in subpackage '$SUB_PKG_NAME' when built for $SUB_PKG_ARCH with package '$CLANDRO_PKG_NAME', so"
			echo "the subpackage was not created. If unexpected, check to make sure the files are where you expect."
			cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
			continue
		fi
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)
		tar --sort=name \
			--mtime="@${SOURCE_DATE_EPOCH}" \
			--owner=0 --group=0 --numeric-owner \
			-cJf "$SUB_PKG_PACKAGE_DIR/data.tar.xz" .

		mkdir -p DEBIAN
		cd DEBIAN

		cat > control <<-HERE
			Package: $SUB_PKG_NAME
			Architecture: ${SUB_PKG_ARCH}
			Installed-Size: ${SUB_PKG_INSTALLSIZE}
			Maintainer: $CLANDRO_PKG_MAINTAINER
			Version: $CLANDRO_PKG_FULLVERSION
			Homepage: $CLANDRO_PKG_HOMEPAGE
		HERE

		# If the subpackage is not in the $CLANDRO_PKG_DEPENDS for the parent package,
		# and CLANDRO_SUBPKG_DEPEND_ON_PARENT doesn't have a value, the subpackage should depend on its parent
		[[ " ${CLANDRO_PKG_DEPENDS//,/ } " != *" $SUB_PKG_NAME "* ]] && : "${CLANDRO_SUBPKG_DEPEND_ON_PARENT:=true}"

		case "$CLANDRO_SUBPKG_DEPEND_ON_PARENT" in
			'unversioned') CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_NAME";;
			'deps')        CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_DEPENDS";;
			'true')        CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_NAME (= $CLANDRO_PKG_FULLVERSION)";;
			*) ;;
		esac

		[[ "$CLANDRO_GLOBAL_LIBRARY" == 'true' && "$CLANDRO_PACKAGE_LIBRARY" == 'glibc' ]] && {
			[[ -n "$CLANDRO_SUBPKG_DEPENDS"    ]] && CLANDRO_SUBPKG_DEPENDS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_DEPENDS")
			[[ -n "$CLANDRO_SUBPKG_BREAKS"     ]] && CLANDRO_SUBPKG_BREAKS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_BREAKS")
			[[ -n "$CLANDRO_SUBPKG_CONFLICTS"  ]] && CLANDRO_SUBPKG_CONFLICTS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_CONFLICTS")
			[[ -n "$CLANDRO_SUBPKG_RECOMMENDS" ]] && CLANDRO_SUBPKG_RECOMMENDS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_RECOMMENDS")
			[[ -n "$CLANDRO_SUBPKG_REPLACES"   ]] && CLANDRO_SUBPKG_REPLACES=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_REPLACES")
			[[ -n "$CLANDRO_SUBPKG_PROVIDES"   ]] && CLANDRO_SUBPKG_PROVIDES=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_PROVIDES")
			[[ -n "$CLANDRO_SUBPKG_SUGGESTS"   ]] && CLANDRO_SUBPKG_SUGGESTS=$(clandro_package__add_prefix_glibc_to_package_list "$CLANDRO_SUBPKG_SUGGESTS")
		}

		{ # add control fields to subpackage
		[[ "$CLANDRO_SUBPKG_ESSENTIAL" == "true" ]] && echo "Essential: yes"
		[[ -n "$CLANDRO_SUBPKG_DEPENDS"          ]] && echo "Depends: ${CLANDRO_SUBPKG_DEPENDS/#, /}"
		[[ -n "$CLANDRO_SUBPKG_BREAKS"           ]] && echo "Breaks: $CLANDRO_SUBPKG_BREAKS"
		[[ -n "$CLANDRO_SUBPKG_CONFLICTS"        ]] && echo "Conflicts: $CLANDRO_SUBPKG_CONFLICTS"
		[[ -n "$CLANDRO_SUBPKG_RECOMMENDS"       ]] && echo "Recommends: $CLANDRO_SUBPKG_RECOMMENDS"
		[[ -n "$CLANDRO_SUBPKG_REPLACES"         ]] && echo "Replaces: $CLANDRO_SUBPKG_REPLACES"
		[[ -n "$CLANDRO_SUBPKG_PROVIDES"         ]] && echo "Provides: $CLANDRO_SUBPKG_PROVIDES"
		[[ -n "$CLANDRO_SUBPKG_SUGGESTS"         ]] && echo "Suggests: $CLANDRO_SUBPKG_SUGGESTS"
		echo "Description: $CLANDRO_SUBPKG_DESCRIPTION"
		} >> control

		for f in $CLANDRO_SUBPKG_CONFFILES; do echo "$CLANDRO_PREFIX_CLASSICAL/$f" >> conffiles; done

		# Allow packages to create arbitrary control files.
		clandro_step_create_subpkg_debscripts
		clandro_step_create_python_debscripts

		# Create control.tar.xz
		tar --sort=name \
			--mtime="@${SOURCE_DATE_EPOCH}" \
			--owner=0 --group=0 --numeric-owner \
			-cJf "$SUB_PKG_PACKAGE_DIR/control.tar.xz" -H gnu .

		# Create the actual .deb file:
		CLANDRO_SUBPKG_DEBFILE=$CLANDRO_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}_${CLANDRO_PKG_FULLVERSION}_${SUB_PKG_ARCH}.deb
		[[ -f "$CLANDRO_COMMON_CACHEDIR/debian-binary" ]] || echo "2.0" > "$CLANDRO_COMMON_CACHEDIR/debian-binary"
		${AR-ar} cr "$CLANDRO_SUBPKG_DEBFILE" \
				   "$CLANDRO_COMMON_CACHEDIR/debian-binary" \
				   "$SUB_PKG_PACKAGE_DIR/control.tar.xz" \
				   "$SUB_PKG_PACKAGE_DIR/data.tar.xz"

		# Go back to main package:
		cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
	done
}
