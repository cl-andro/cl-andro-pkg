# shellcheck shell=bash
clandro_setup_cabal() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" ]]; then
		local CLANDRO_CABAL_VERSION=3.14.1.1
		local CLANDRO_CABAL_TAR="${CLANDRO_COMMON_CACHEDIR}/cabal-${CLANDRO_CABAL_VERSION}.tar.xz"

		local CLANDRO_CABAL_RUNTIME_FOLDER

		if [[ "${CLANDRO_PACKAGES_OFFLINE-false}" == "true" ]]; then
			CLANDRO_CABAL_RUNTIME_FOLDER="${CLANDRO_SCRIPTDIR}/build-tools/cabal-${CLANDRO_CABAL_VERSION}-runtime"
		else
			CLANDRO_CABAL_RUNTIME_FOLDER="${CLANDRO_COMMON_CACHEDIR}/cabal-${CLANDRO_CABAL_VERSION}-runtime"
		fi

		export PATH="${CLANDRO_CABAL_RUNTIME_FOLDER}:${PATH}"
		export CLANDRO_CABAL_CONFIG="$CLANDRO_CABAL_RUNTIME_FOLDER/cabal.config"

		[[ -d "${CLANDRO_CABAL_RUNTIME_FOLDER}" ]] && return

		clandro_download "https://downloads.haskell.org/~cabal/cabal-install-${CLANDRO_CABAL_VERSION}/cabal-install-${CLANDRO_CABAL_VERSION}-x86_64-linux-ubuntu22_04.tar.xz" \
			"${CLANDRO_CABAL_TAR}" \
			773633b5fff7f26abd6d9388b4ab7ef35b0cd544612ec34ab91ef9bc24438619

		mkdir -p "${CLANDRO_CABAL_RUNTIME_FOLDER}"
		tar xf "${CLANDRO_CABAL_TAR}" -C "${CLANDRO_CABAL_RUNTIME_FOLDER}"
		rm "${CLANDRO_CABAL_TAR}"

		cabal update

		# Configuration:

		local repo="hackage.haskell.org"

		cat <<-EOF >"$CLANDRO_CABAL_CONFIG"
			repository hackage.haskell.org
			 url: https://$repo/

			remote-repo-cache: $HOME/.cache/cabal/packages
			configure-option: --host=$CLANDRO_HOST_PLATFORM
			tests: False
			build-summary: $HOME/.cache/cabal/logs/build.log
			remote-build-reporting: none
			jobs: $CLANDRO_PKG_MAKE_PROCESSES

			program-locations
			 alex-location: $(command -v alex)
			 happy-location: $(command -v happy)

			program-default-options
			 $([[ "$CLANDRO_ON_DEVICE_BUILD" == false ]] && printf "%s" "hsc2hs-options: --cross-compile")
		EOF
	else
		if [[ "${CLANDRO_APP_PACKAGE_MANAGER}" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' cabal-install 2>/dev/null)" != "installed" ||
			[[ "${CLANDRO_APP_PACKAGE_MANAGER}" == "pacman" ]] && ! "$(pacman -Q cabal-install 2>/dev/null)"; then
			echo "Package 'cabal-install' is not installed."
			exit 1
		fi
	fi
}
