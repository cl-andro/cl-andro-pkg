clandro_create_pacman_subpackages() {
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
		local CLANDRO_SUBPKG_GROUPS=""
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
		for includeset in $CLANDRO_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			[[ "$_INCLUDE_DIRSET" == "." ]] && _INCLUDE_DIRSET=""

			if [[ -e "$includeset" || -L "$includeset" ]]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			fi
		done
		shopt -u globstar

		local SUB_PKG_ARCH=$CLANDRO_ARCH
		[[ "$CLANDRO_SUBPKG_PLATFORM_INDEPENDENT" == "true" ]] && SUB_PKG_ARCH=any

		cd "$SUB_PKG_DIR/massage"
		# Check that files were actually installed, else don't subpackage.
		if [[ "$SUB_PKG_ARCH" == "any" && "$(find . -type f -print | head -n1)" == "" ]]; then
			echo "No files in subpackage '$SUB_PKG_NAME' when built for $SUB_PKG_ARCH with package '$CLANDRO_PKG_NAME', so"
			echo "the subpackage was not created. If unexpected, check to make sure the files are where you expect."
			cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
			continue
		fi
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -bs . | cut -f 1)

		# If the subpackage is not in the $CLANDRO_PKG_DEPENDS for the parent package,
		# and CLANDRO_SUBPKG_DEPEND_ON_PARENT doesn't have a value, the subpackage should depend on its parent
		[[ " ${CLANDRO_PKG_DEPENDS//,/ } " != *" $SUB_PKG_NAME "* ]] && : "${CLANDRO_SUBPKG_DEPEND_ON_PARENT:=true}"

		case "$CLANDRO_SUBPKG_DEPEND_ON_PARENT" in
			'unversioned') CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_NAME";;
			'deps')        CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_DEPENDS";;
			# TODO: pacman does support versioned dependencies
			# but we are not currently translating the .DEB notation to pacman's
			'true')        CLANDRO_SUBPKG_DEPENDS+=", $CLANDRO_PKG_NAME";;
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

		# Package metadata.
		{
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $CLANDRO_PKG_NAME"
			echo "pkgver = $CLANDRO_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgdesc = $(echo "$CLANDRO_SUBPKG_DESCRIPTION" | tr '\n' ' ')"
			echo "url = $CLANDRO_PKG_HOMEPAGE"
			echo "builddate = $SOURCE_DATE_EPOCH"
			echo "packager = $CLANDRO_PKG_MAINTAINER"
			echo "size = $SUB_PKG_INSTALLSIZE"
			echo "arch = $SUB_PKG_ARCH"

			if [[ -n "$CLANDRO_SUBPKG_REPLACES" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_REPLACES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "replaces = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_CONFLICTS" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_CONFLICTS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_BREAKS" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_BREAKS" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "conflict = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_PROVIDES" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_PROVIDES" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "provides = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_DEPENDS" ]]; then
				tr ',' '\n' <<< "${CLANDRO_SUBPKG_DEPENDS/#, /}" | sed 's|(||g; s|)||g; s| ||g; s|>>|>|g; s|<<|<|g' | awk '{ printf "depend = " $1; if ( ($1 ~ /</ || $1 ~ />/ || $1 ~ /=/) && $1 !~ /-/ ) printf "-0"; printf "\n" }' | sed 's/|.*//'
			fi

			if [[ -n "$CLANDRO_SUBPKG_RECOMMENDS" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_RECOMMENDS" | awk '{ printf "optdepend = %s\n", $1 }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_SUGGESTS" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_SUGGESTS" | awk '{ printf "optdepend = %s\n", $1 }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_CONFFILES" ]]; then
				tr ',' '\n' <<< "$CLANDRO_SUBPKG_CONFFILES" | awk '{ printf "backup = '"${CLANDRO_PREFIX_CLASSICAL:1}"'/%s\n", $1 }'
			fi

			if [[ -n "$CLANDRO_SUBPKG_GROUPS" ]]; then
				tr ',' '\n' <<< "${CLANDRO_SUBPKG_GROUPS/#, /}" | awk '{ printf "group = %s\n", $1 }'
			fi
		} > .PKGINFO

		# Build metadata.
		{
			echo "format = 2"
			echo "pkgname = $SUB_PKG_NAME"
			echo "pkgbase = $CLANDRO_PKG_NAME"
			echo "pkgver = $CLANDRO_PKG_FULLVERSION_FOR_PACMAN"
			echo "pkgarch = $SUB_PKG_ARCH"
			echo "packager = $CLANDRO_PKG_MAINTAINER"
			echo "builddate = $SOURCE_DATE_EPOCH"
		} > .BUILDINFO

		# Write package installation hooks.
		clandro_step_create_subpkg_debscripts
		clandro_step_create_python_debscripts
		clandro_step_create_pacman_install_hook

		# Configuring the selection of a copress for a batch.
		local COMPRESS
		local PKG_FORMAT
		case $CLANDRO_PACMAN_PACKAGE_COMPRESSION in
			"gzip")
				COMPRESS=(gzip -c -f -n)
				PKG_FORMAT="gz";;
			"bzip2")
				COMPRESS=(bzip2 -c -f)
				PKG_FORMAT="bz2";;
			"zstd")
				COMPRESS=(zstd -c -z -q -)
				PKG_FORMAT="zst";;
			"lrzip")
				COMPRESS=(lrzip -q)
				PKG_FORMAT="lrz";;
			"lzop")
				COMPRESS=(lzop -q)
				PKG_FORMAT="lzop";;
			"lz4")
				COMPRESS=(lz4 -q)
				PKG_FORMAT="lz4";;
			"lzip")
				COMPRESS=(lzip -c -f)
				PKG_FORMAT="lz";;
			"xz" | *)
				COMPRESS=(xz -c -z -)
				PKG_FORMAT="xz";;
		esac

		# ensure all elements of the package have the same mtime
		find . -exec touch -h -d @$SOURCE_DATE_EPOCH {} +

		# Create the actual .pkg file:
		local CLANDRO_SUBPKG_PACMAN_FILE=$CLANDRO_OUTPUT_DIR/${SUB_PKG_NAME}${DEBUG}-${CLANDRO_PKG_FULLVERSION_FOR_PACMAN}-${SUB_PKG_ARCH}.pkg.tar.${PKG_FORMAT}
		shopt -s dotglob globstar
		printf '%s\0' **/* | bsdtar -cnf - --format=mtree \
			--options='!all,use-set,type,uid,gid,mode,time,size,md5,sha256,link' \
			--null --files-from - --exclude .MTREE | \
			gzip -c -f -n > .MTREE
		touch -d @$SOURCE_DATE_EPOCH .MTREE
		printf '%s\0' **/* | bsdtar --no-fflags -cnf - --null --files-from - | \
			$COMPRESS > "$CLANDRO_SUBPKG_PACMAN_FILE"
		shopt -u dotglob globstar

		# Go back to main package:
		cd "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL"
	done
}
