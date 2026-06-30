# shellcheck shell=bash disable=SC1091 disable=SC2086 disable=SC2155
clandro_setup_rust() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then
		if [[ -z "$(command -v rustc)" ]]; then
			cat <<- EOL
			Package 'rust' is not installed.
			You can install it with

			pkg install rust

			pacman -S rust
			EOL
			exit 1
		fi
		local RUSTC_VERSION=$(rustc --version | awk '{ print $2 }')
		if [[ -n "${CLANDRO_RUST_VERSION-}" && "${CLANDRO_RUST_VERSION-}" != "${RUSTC_VERSION}" ]]; then
			cat <<- EOL >&2
			WARN: On device build with old rust version is not possible!
			CLANDRO_RUST_VERSION = ${CLANDRO_RUST_VERSION}
			RUSTC_VERSION       = ${RUSTC_VERSION}
			EOL
		fi
		return
	fi

	if [[ -z "${CLANDRO_RUST_VERSION-}" ]]; then
		CLANDRO_RUST_VERSION=$(. "${CLANDRO_SCRIPTDIR}"/packages/rust/build.sh; echo ${CLANDRO_PKG_VERSION})
	fi
	if [[ "${CLANDRO_RUST_VERSION}" == *"~beta"* ]]; then
		CLANDRO_RUST_VERSION="beta"
	fi

	curl https://sh.rustup.rs -sSfo "${CLANDRO_PKG_TMPDIR}"/rustup.sh
	sh "${CLANDRO_PKG_TMPDIR}"/rustup.sh -y --default-toolchain "${CLANDRO_RUST_VERSION}"

	export PATH="${HOME}/.cargo/bin:${PATH}"

	if [[ -n "${CARGO_TARGET_NAME-}" ]]; then
		# Specific version toolchain
		rustup target add "${CARGO_TARGET_NAME}" --toolchain "${CLANDRO_RUST_VERSION}"
		# Default / Stable / rust-toolchain.toml toolchain
		rustup target add "${CARGO_TARGET_NAME}"
	fi
}
