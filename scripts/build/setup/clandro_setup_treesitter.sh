clandro_setup_treesitter() {
	local CLANDRO_TREE_SITTER_VERSION
	CLANDRO_TREE_SITTER_VERSION="$(. "$CLANDRO_SCRIPTDIR/packages/tree-sitter/build.sh"; echo "$CLANDRO_PKG_VERSION")"
	CLANDRO_TREE_SITTER_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${CLANDRO_TREE_SITTER_VERSION}/tree-sitter-linux-x64.gz"
	local CLANDRO_TREE_SITTER_SHA256=9754a32800f0b970152782df177b4a47c711e34e651a7aceb384d8bd29fa136e

	local CLANDRO_TREE_SITTER_GZNAME="tree-sitter-linux-x64.gz"
	local CLANDRO_TREE_SITTER_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${CLANDRO_TREE_SITTER_VERSION}/${CLANDRO_TREE_SITTER_GZNAME}"
	CLANDRO_TREE_SITTER_DIR="${CLANDRO_COMMON_CACHEDIR}/tree-sitter-${CLANDRO_TREE_SITTER_VERSION}"

	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then
		local TREE_SITTER_INSTALL_COMMAND=""
		case "$CLANDRO_APP_PACKAGE_MANAGER" in
			"apt")
				if [[ "$(dpkg-query -W -f '${db:Status-Status}\n' tree-sitter 2>/dev/null)" != "installed" ]]; then
					TREE_SITTER_INSTALL_COMMAND="apt update && apt install tree-sitter"
				fi
			;;
			"pacman")
				if ! pacman -Q tree-sitter 2>/dev/null; then
					TREE_SITTER_INSTALL_COMMAND="pacman -Syu tree-sitter"
				fi
			;;
		esac
		if (( ${#TREE_SITTER_INSTALL_COMMAND} )); then
			echo "Package 'tree-sitter' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install tree-sitter"
			echo
			echo "  $TREE_SITTER_INSTALL_COMMAND"
			echo
			exit 1
		fi
		return
	fi

	if [[ "$( "${CLANDRO_TREE_SITTER_DIR}/bin/tree-sitter" --version | cut -f2 -d' ')" != "$CLANDRO_TREE_SITTER_VERSION" ]]; then
		echo "clandro_step_setup_treesitter: installing tree-sitter $CLANDRO_TREE_SITTER_VERSION"
		clandro_download "${CLANDRO_TREE_SITTER_URL}" \
			"${CLANDRO_PKG_TMPDIR}/${CLANDRO_TREE_SITTER_GZNAME}" \
			"${CLANDRO_TREE_SITTER_SHA256}"

		gunzip "$CLANDRO_PKG_TMPDIR/${CLANDRO_TREE_SITTER_GZNAME}"
		install -v -Dm700 "$CLANDRO_PKG_TMPDIR/tree-sitter-linux-x64" "$CLANDRO_TREE_SITTER_DIR/tree-sitter"
	else
		echo "clandro_step_setup_treesitter: tree-sitter $CLANDRO_TREE_SITTER_VERSION is already installed"
		ls -lh "$CLANDRO_TREE_SITTER_DIR/tree-sitter"
	fi

	# Default to the latest ABI version, can be overridden per package as necessary.
	: "${TREE_SITTER_ABI_VERSION:=15}"

	# Symlink in the parser build helper as well.
	ln -sf "$CLANDRO_SCRIPTDIR/packages/tree-sitter/clandro-tree-sitter" "${CLANDRO_TREE_SITTER_DIR}"
	export PATH="${CLANDRO_TREE_SITTER_DIR}:${PATH}"

	# ABI version to build the parser against.
	export TREE_SITTER_ABI_VERSION
	# Needed for pkgconfig files
	# shellcheck disable=SC2031
	export CLANDRO_PREFIX CLANDRO_PKG_VERSION CLANDRO_PKG_DESCRIPTION CLANDRO_PKG_HOMEPAGE

}
