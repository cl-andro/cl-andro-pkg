# shellcheck shell=bash
# Utility script to setup jailbreak-cabal script. It is used by haskell build system to remove version
# constraints in cabal files.
clandro_setup_jailbreak_cabal() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "false" ]]; then
		local CLANDRO_JAILBREAK_VERSION=1.3.5
		local CLANDRO_JAILBREAK_TAR="${CLANDRO_COMMON_CACHEDIR}/jailbreak-cabal-${CLANDRO_JAILBREAK_VERSION}.tar.gz"
		local CLANDRO_JAILBREAK_RUNTIME_FOLDER

		if [[ "${CLANDRO_PACKAGES_OFFLINE-false}" == "true" ]]; then
			CLANDRO_JAILBREAK_RUNTIME_FOLDER="${CLANDRO_SCRIPTDIR}/build-tools/jailbreak-cabal-${CLANDRO_JAILBREAK_VERSION}-runtime"
		else
			CLANDRO_JAILBREAK_RUNTIME_FOLDER="${CLANDRO_COMMON_CACHEDIR}/jailbreak-cabal-${CLANDRO_JAILBREAK_VERSION}-runtime"
		fi

		export PATH="${CLANDRO_JAILBREAK_RUNTIME_FOLDER}:${PATH}"

		[[ -d "${CLANDRO_JAILBREAK_RUNTIME_FOLDER}" ]] && return

		clandro_download "https://github.com/MrAdityaAlok/ghc-cross-tools/releases/download/jailbreak-cabal-v${CLANDRO_JAILBREAK_VERSION}/jailbreak-cabal-${CLANDRO_JAILBREAK_VERSION}.tar.xz" \
			"${CLANDRO_JAILBREAK_TAR}" \
			"8d1a8b8fadf48f4abf42da025d5cf843bd68e1b3c18ecacdc0cd0c9bd470c64e"

		mkdir -p "${CLANDRO_JAILBREAK_RUNTIME_FOLDER}"
		tar xf "${CLANDRO_JAILBREAK_TAR}" -C "${CLANDRO_JAILBREAK_RUNTIME_FOLDER}"

		rm "${CLANDRO_JAILBREAK_TAR}"
	else
		if [[ "${CLANDRO_APP_PACKAGE_MANAGER}" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' jailbreak-cabal 2>/dev/null)" != "installed" ||
			[[ "${CLANDRO_APP_PACKAGE_MANAGER}" = "pacman" ]] && ! "$(pacman -Q jailbreak-cabal 2>/dev/null)"; then
			echo "Package 'jailbreak-cabal' is not installed."
			exit 1
		fi
	fi
}
