clandro_git_clone_src() {
	local TMP_CHECKOUT=$CLANDRO_PKG_CACHEDIR/tmp-checkout
	local TMP_CHECKOUT_VERSION=$CLANDRO_PKG_CACHEDIR/tmp-checkout-version
	local clandro_pkg_srcurl="${CLANDRO_PKG_SRCURL:4}"
	local clandro_pkg_local_srcpath=""
	local clandro_pkg_branch_flags=""

	if [[ "$clandro_pkg_srcurl" =~ ^file://(/[^/]+)+$ ]]; then
		clandro_pkg_local_srcpath="${clandro_pkg_srcurl:7}" # Remove `file://` prefix

		if [ ! -d "$clandro_pkg_local_srcpath" ]; then
			echo "No source directory found at path of CLANDRO_PKG_SRCURL '$CLANDRO_PKG_SRCURL' of package '$CLANDRO_PKG_NAME'"
			return 1
		elif [ ! -d "$clandro_pkg_local_srcpath/.git" ]; then
			echo "The source directory at path of CLANDRO_PKG_SRCURL '$CLANDRO_PKG_SRCURL' of package '$CLANDRO_PKG_NAME' does not a contain a '.git' sub directory"
			return 1
		fi
	fi

	if [ ! -f $TMP_CHECKOUT_VERSION ] || [ "$(cat $TMP_CHECKOUT_VERSION)" != "$CLANDRO_PKG_VERSION" ]; then
		if [[ -n "$clandro_pkg_local_srcpath" ]]; then
			if [ "$CLANDRO_PKG_GIT_BRANCH" != "" ]; then
				# The local git repository that needs to be cloned may
				# not have a branch created that is tracking its remote
				# branch, so we create it if it doesn't exist without
				# checking it out, otherwise when we clone below,
				# git will fail to find the branch in its own origin
				# i.e the local git repository, as it will not look
				# into the origin of the local git repository recursively.
				(cd "$clandro_pkg_local_srcpath" && git fetch origin $CLANDRO_PKG_GIT_BRANCH:$CLANDRO_PKG_GIT_BRANCH)
				clandro_pkg_branch_flags="--branch $CLANDRO_PKG_GIT_BRANCH"
			fi
		else
			if [ "$CLANDRO_PKG_GIT_BRANCH" == "" ]; then
				clandro_pkg_branch_flags="--branch v${CLANDRO_PKG_VERSION#*:}"
			else
				clandro_pkg_branch_flags="--branch $CLANDRO_PKG_GIT_BRANCH"
			fi
		fi

		echo "Downloading git source $([[ "$clandro_pkg_branch_flags" != "" ]] && echo "with branch '${clandro_pkg_branch_flags:9}' ")from '$clandro_pkg_srcurl'"

		rm -rf "$TMP_CHECKOUT"
		git clone \
			--depth 1 \
			$clandro_pkg_branch_flags \
			"$clandro_pkg_srcurl" \
			"$TMP_CHECKOUT"

		pushd "$TMP_CHECKOUT"

		# Workaround some bad server behaviour
		# error: Server does not allow request for unadvertised object commit_no
		# fatal: Fetched in submodule 'submodule_path', but it did not contain commit_no. Direct fetching of that commit failed.
		if ! git submodule update --init --recursive --depth=1; then
			local depth=10
			local maxdepth=100
			sleep 1
			while :; do
				echo "WARN: Retrying with max depth $depth"
				if git submodule update --init --recursive --depth=$depth; then
					break
				fi
				if [[ "$depth" -gt "$maxdepth" ]]; then
					clandro_error_exit "Failed to clone submodule"
				fi
				depth=$((depth+10))
				sleep 1
			done
		fi

		popd

		echo "$CLANDRO_PKG_VERSION" > "$TMP_CHECKOUT_VERSION"
	else
		echo "Skipped downloading of git source from '$clandro_pkg_srcurl'"
	fi

	rm -rf "$CLANDRO_PKG_SRCDIR"
	cp -Rf "$TMP_CHECKOUT" "$CLANDRO_PKG_SRCDIR"
}
