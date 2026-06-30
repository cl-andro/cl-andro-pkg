CLANDRO_PKG_HOMEPAGE=https://lux.lumen-labs.org
CLANDRO_PKG_DESCRIPTION="A package manager for Lua, similar to luarocks"
CLANDRO_PKG_LICENSE="LGPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.28.9"
CLANDRO_PKG_SRCURL="https://github.com/lumen-oss/lux/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=93096c52e7aae6154c6d3cc6c9ea343c965589036c3ecf2f2383e925a974a893
CLANDRO_PKG_DEPENDS="bzip2, gpgme, libgit2, libgpg-error, lua54, openssl, xz-utils"
CLANDRO_PKG_PROVIDES="lx"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_pkg_auto_update() {
	# based on `clandro_github_api_get_tag.sh`
	# fetch newest tags
	local newest_tags newest_tag
	newest_tags="$(curl -d "$(cat <<-EOF | tr '\n' ' '
	{
		"query": "query {
			repository(owner: \"lumen-oss\", name: \"lux\") {
				refs(refPrefix: \"refs/tags/\", first: 20, orderBy: {
					field: TAG_COMMIT_DATE, direction: DESC
				})
				{ edges { node { name } } }
			}
		}"
	}
	EOF
	)" \
		-H "Authorization: token ${GITHUB_TOKEN}" \
		-H "Accept: application/vnd.github.v3+json" \
		--silent \
		--location \
		--retry 10 \
		--retry-delay 1 \
		https://api.github.com/graphql \
		| jq '.data.repository.refs.edges[].node.name')"
	# filter only tags having "v" at the start and extract only raw version.
	read -r newest_tag < <(echo "$newest_tags" | grep -Po '(?<=^"v)\d+\.\d+\.\d+' | sort -Vr)

	[[ -z "${newest_tag}" ]] && clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	clandro_pkg_upgrade_version "${newest_tag}"
}

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	# libgpgme-dev and any dependencies that aren't in the ubuntu builder at time of writing
	local -a ubuntu_packages=(
		"dirmngr"
		"gnupg"
		"gnupg-l10n"
		"gnupg-utils"
		"gpg"
		"gpg-agent"
		"gpg-wks-client"
		"gpgconf"
		"gpgsm"
		"gpgv"
		"keyboxd"
		"libassuan-dev"
		"libgpgme-dev"
		"libgpgme11t64"
	)

	clandro_download_ubuntu_packages "${ubuntu_packages[@]}"

	PKG_CONFIG_PATH_x86_64_unknown_linux_gnu="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages/usr/lib/x86_64-linux-gnu/pkgconfig"
	RUSTFLAGS="-L${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages/usr/lib/x86_64-linux-gnu"

	export PKG_CONFIG_PATH_x86_64_unknown_linux_gnu RUSTFLAGS

	cd "${CLANDRO_PKG_SRCDIR}" || clandro_error_exit "Couldn't enter source code directory: ${CLANDRO_PKG_SRCDIR}"

	clandro_setup_rust

	cargo fetch --locked

	# build shell completions
	cargo run --package xtask --release --frozen -- dist-completions

	unset PKG_CONFIG_PATH_x86_64_unknown_linux_gnu RUSTFLAGS

	# preserve the hostbuilt shell completions
	rm -rf "${CLANDRO_PKG_HOSTBUILD_DIR}/dist/"
	cp -r "${CLANDRO_PKG_SRCDIR}/target/dist/" "${CLANDRO_PKG_HOSTBUILD_DIR}/"
}

clandro_step_pre_configure() {
	# software does not officially support cross-compilation, but for some reason, it appears to work anyway
	# https://github.com/lumen-oss/lux/blob/c794f476cb459df5bcb6e971c0c6f76e6a2a4dd4/lux-lib/src/lua_rockspec/platform.rs#L72
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		echo "WARNING: $CLANDRO_PKG_NAME's upstream project does not officially support cross-compilation!"
	fi

	clandro_setup_rust

	# ld: error: undefined symbol: __atomic_compare_exchange
	# ld: error: undefined symbol: __atomic_load
	# ld: error: undefined symbol: __atomic_is_lock_free
	if [[ "${CLANDRO_ARCH}" == "i686" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi

	cargo fetch --locked --target "$CARGO_TARGET_NAME"
}

clandro_step_make() {
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release --frozen

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		# build shell completions
		cargo run --package xtask --release --frozen -- dist-completions

		rm -rf "${CLANDRO_PKG_HOSTBUILD_DIR}/dist/"
		cp -r "${CLANDRO_PKG_SRCDIR}/target/dist/" "${CLANDRO_PKG_HOSTBUILD_DIR}/"
	fi
}

clandro_step_make_install() {
	local _cargo_target_dir _completions_dir
	_cargo_target_dir="$CLANDRO_PKG_BUILDDIR/target"
	_completions_dir="$CLANDRO_PKG_HOSTBUILD_DIR/dist"

	install -Dm755 -t "$CLANDRO_PREFIX/bin" "$_cargo_target_dir/$CARGO_TARGET_NAME/release/lx"

	install -Dm644 "$_completions_dir/lx.bash" "$CLANDRO_PREFIX/share/bash-completion/completions/lx"
	install -Dm644 -t "$CLANDRO_PREFIX/share/zsh/site-functions" "$_completions_dir/_lx"
	install -Dm644 -t "$CLANDRO_PREFIX/share/fish/vendor_completions.d" "$_completions_dir/lx.fish"
}
