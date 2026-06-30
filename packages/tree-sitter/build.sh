CLANDRO_PKG_HOMEPAGE=https://tree-sitter.github.io/
CLANDRO_PKG_DESCRIPTION="An incremental parsing system for programming tools"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.26.8"
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e6826b7533ec3a885aba598377a6d20b5a6321ff3db76968e960c2352d3a5077
CLANDRO_PKG_BREAKS="libtreesitter"
CLANDRO_PKG_REPLACES="libtreesitter"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_pkg_auto_update() {
	local latest_release
	latest_release="$(clandro_github_api_get_tag)"

	# Since we specify a 'CLANDRO_PKG_UPDATE_VERSION_REGEXP' we get back a range of tags.
	# We should only return the first match against the RegEx for further checking.
	if ! latest_release="$(grep --max-count=1 -oP "${CLANDRO_PKG_UPDATE_VERSION_REGEXP}" <<< "${latest_release}")"; then
		clandro_error_exit <<- EOF
			Failed to parse returned tag range.
			$latest_release
		EOF
	fi

	# Is there a new release?
	if [[ "${latest_release}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	# Do not forget to bump revision of reverse dependencies
	# and rebuild them after SOVERSION has changed.
	local _SOVERSION=0.26

	# This blocks auto-updates to an incompatible SO version.
	if [[ "${latest_release}" != "${_SOVERSION}".* ]]; then
		clandro_error_exit <<- EOF
			SOVERSION guard check failed.
			Latest release (${latest_release}) seems to contain breaking ABI changes.
			'${latest_release}' != '${_SOVERSION}'
		EOF
	fi

	# Bail here if we're not building packages
	# since the step below modifies a setup script.
	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_release}."
		return
	fi

	# Figure out the new SHA256 for the `clandro_setup_treesitter` function.
	local TS_BIN_URL NEW_TS_SHA256
	TS_BIN_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${latest_release}/tree-sitter-linux-x64.gz"
	NEW_TS_SHA256="$(curl -sL "$TS_BIN_URL" | sha256sum | cut -d' ' -f1)"

	# Replace the SHA256 sum for the `tree-sitter` binary in `clandro_setup_treesitter.sh`
	sed \
		-e "s|\(^\s*\)local CLANDRO_TREE_SITTER_SHA256=[0-9a-f]*|\1local CLANDRO_TREE_SITTER_SHA256=${NEW_TS_SHA256}|" \
		-i "${CLANDRO_SCRIPTDIR}/scripts/build/setup/clandro_setup_treesitter.sh"

	clandro_pkg_upgrade_version "${latest_release}"
}

clandro_step_pre_configure() {
	clandro_setup_rust
	# clash with rust host build
	# causes 32bit builds to fail if set
	unset CFLAGS

	# error: function-like macro '__GLIBC_USE' is not defined
	# solution borrowed from packages/oma/build.sh
	export BINDGEN_EXTRA_CLANG_ARGS_${CARGO_TARGET_NAME//-/_}="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot --target=${CARGO_TARGET_NAME}"
}

clandro_step_post_make_install() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
	install -Dm700 -t "$CLANDRO_PREFIX"/bin target/"${CARGO_TARGET_NAME}"/release/tree-sitter

	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	mkdir -p "${CLANDRO_PREFIX}/share/nushell/vendor/autoload"
	cargo run -- complete --shell     zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	cargo run -- complete --shell    bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	cargo run -- complete --shell    fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- complete --shell  elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
	cargo run -- complete --shell nushell > "${CLANDRO_PREFIX}/share/nushell/vendor/autoload/${CLANDRO_PKG_NAME}.nu"
}
