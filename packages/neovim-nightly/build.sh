CLANDRO_PKG_HOMEPAGE=https://neovim.io/
CLANDRO_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim-nightly)"
CLANDRO_PKG_LICENSE="Apache-2.0, VIM License"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.13.0~dev-141+gc4b592a6d0"
CLANDRO_PKG_SRCURL="https://github.com/neovim/neovim/archive/${CLANDRO_PKG_VERSION##*+g}.tar.gz"
CLANDRO_PKG_SHA256=ab506eecc4abf0494f1b5001d937ab6564022f2cc1af0d6546885b61097b1bd8
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="${CLANDRO_PKG_VERSION%%~*}"
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv, libmsgpack, libunibilium, libuv, libvterm (>= 1:0.3-0), lua51-lpeg, luajit, luv, tree-sitter, tree-sitter-parsers, utf8proc"
CLANDRO_PKG_BREAKS="neovim"
CLANDRO_PKG_CONFLICTS="neovim"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_CONFFILES="share/nvim/sysinit.vim"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="v.*-dev.*\+g[0-9a-f]*"
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/-/~/"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DLUAJIT_INCLUDE_DIR=$CLANDRO_PREFIX/include/luajit-2.1
-DLPEG_LIBRARY=$CLANDRO_PREFIX/lib/liblpeg-5.1.so
-DCOMPILE_LUA=OFF
-DNLUA0_HOST_PRG=$CLANDRO_PKG_HOSTBUILD_DIR/libnlua0.so
-DNVIM_HOST_PRG=$CLANDRO_PKG_HOSTBUILD_DIR/nvim
"

clandro_pkg_auto_update() {
	local response commit latest_nightly
	response="$(curl -sL \
		-H "Accept: application/vnd.github+json" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		https://api.github.com/repos/neovim/neovim/releases/tags/nightly
	)"

	commit="$(jq -r '.target_commitish' <<< "$response")"
	if [[ -z "${commit:-}" ]]; then
		{
			echo "WARN: Couldn't fetch latest nightly tag from "
			echo "https://api.github.com/repos/neovim/neovim/releases/tags/nightly"
			echo "curl response:"
			jq '.' <<< "$response"
		} >&2
		return
	elif [[ "${commit::10}" == "${CLANDRO_PKG_VERSION##*+g}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	latest_nightly="$(grep --max-count=1 -oP "$CLANDRO_PKG_UPDATE_VERSION_REGEXP" < <(jq -r '.body' <<< "$response"))"
	# We already filtered the version, so unset the regex to avoid reapplying it.
	unset CLANDRO_PKG_UPDATE_VERSION_REGEXP

	clandro_pkg_upgrade_version "${latest_nightly}"
}

clandro_step_host_build() {
	clandro_setup_cmake

	mkdir -p "$CLANDRO_PKG_HOSTBUILD_DIR/deps"
	cd "$CLANDRO_PKG_HOSTBUILD_DIR/deps" || clandro_error_exit "failed to perform host build for nvim"
	cmake "$CLANDRO_PKG_SRCDIR/cmake.deps"

	make -j 1

	cd "$CLANDRO_PKG_SRCDIR" || clandro_error_exit "failed to perform host build for nvim"

	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$CLANDRO_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install

	# Copy away host-built libnlua0.so for use as -DNLUA0_HOST_PRG
	cp -vf ./build/lib/libnlua0.so "$CLANDRO_PKG_HOSTBUILD_DIR/"

	# Copy away host-built nvim for use as -DNVIM_HOST_PRG
	cp -vf ./build/bin/nvim "$CLANDRO_PKG_HOSTBUILD_DIR/"

	make distclean
	rm -Rf build/
}

clandro_step_post_make_install() {
	local _CONFIG_DIR=$CLANDRO_PREFIX/share/nvim
	mkdir -p "$_CONFIG_DIR"

	# Tree-sitter grammars are packaged separately and installed into CLANDRO_PREFIX/lib/tree_sitter.
	rm -f "${CLANDRO_PREFIX}"/share/nvim/runtime/parser
	ln -sf "${CLANDRO_PREFIX}"/lib/tree_sitter "${CLANDRO_PREFIX}"/share/nvim/runtime/parser

	# Move the `nvim` binary to $PREFIX/libexec
	# and replace it with our LD_PRELOAD shim.
	# See: packages/neovim/nvim-shim.sh for details.
	mkdir -p "$CLANDRO_PREFIX/libexec/nvim"
	mv "${CLANDRO_PREFIX}"/bin/nvim "${CLANDRO_PREFIX}"/libexec/nvim
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"$CLANDRO_PKG_BUILDER_DIR/nvim-shim.sh" \
		> "${CLANDRO_PREFIX}/bin/nvim"
	chmod 700 "${CLANDRO_PREFIX}/bin/nvim"

	# Add termux specific configuration
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"$CLANDRO_PKG_BUILDER_DIR/sysinit.vim" \
		> "$_CONFIG_DIR/sysinit.vim"

	{ # Set up a wrapper script for `ex` to be called by `update-alternatives`
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "exec \"$CLANDRO_PREFIX/bin/nvim\" -e \"\$@\""
	} > "$CLANDRO_PREFIX/libexec/nvim/ex"

	{ # Set up a wrapper script for `view` to be called by `update-alternatives`
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "exec \"$CLANDRO_PREFIX/bin/nvim\" -R \"\$@\""
	} > "$CLANDRO_PREFIX/libexec/nvim/view"

	{ # Set up a wrapper script for `vimdiff` to be called by `update-alternatives`
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "exec \"$CLANDRO_PREFIX/bin/nvim\" -d \"\$@\""
	} > "$CLANDRO_PREFIX/libexec/nvim/vimdiff"

	{ # Set up a wrapper script for `vimtutor` to be called by `update-alternatives`
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "exec \"$CLANDRO_PREFIX/bin/nvim\" +Tutor \"\$@\""
	} > "$CLANDRO_PREFIX/libexec/nvim/vimtutor"
	chmod 700 "$CLANDRO_PREFIX/libexec/nvim/"{ex,view,vimdiff,vimtutor}
}
