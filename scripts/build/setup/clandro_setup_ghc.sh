# shellcheck shell=bash
# Utility function to setup a GHC cross-compiler toolchain targeting Android.
clandro_setup_ghc() {
	local CLANDRO_GHC_VERSION=9.12.2
	local GHC_PREFIX="ghc-cross-$CLANDRO_GHC_VERSION-$CLANDRO_ARCH"
	local CLANDRO_GHC_TEMP_FOLDER="$CLANDRO_COMMON_CACHEDIR/$GHC_PREFIX"
	local CLANDRO_GHC_TAR="$CLANDRO_GHC_TEMP_FOLDER.tar.xz"
	local CLANDRO_GHC_RUNTIME_FOLDER

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == false ]]; then

		if [[ "${CLANDRO_PACKAGES_OFFLINE-false}" == true ]]; then
			CLANDRO_GHC_RUNTIME_FOLDER="$CLANDRO_SCRIPTDIR/build-tools/$GHC_PREFIX-runtime"
		else
			CLANDRO_GHC_RUNTIME_FOLDER="$CLANDRO_COMMON_CACHEDIR/$GHC_PREFIX-runtime"
		fi

		export PATH="$CLANDRO_GHC_RUNTIME_FOLDER/bin:$PATH"

		[[ -d "$CLANDRO_GHC_RUNTIME_FOLDER" ]] && return

		declare -A checksums=(
			["aarch64"]="a9a70c178d3b7cd5733730d93c00975b9957e164f203d80ba04e53cd76c54183"
			["arm"]="173c3b9bbc37afb47edb5f1f2f287064c37c7b4ef19ce787e6d82970e7c5f9cf"
			["i686"]="77315c0eeae163d5a21077c86d1c2f6f0192fdc6cb6fe1e377fc1115cfb073d4"
			["x86_64"]="07a289d912be3a9ae75aa5e2ae5f22d577fabd3a13331de3e6f318d7545fd38a"
		)

		local target="$CLANDRO_HOST_PLATFORM"
		[[ "$CLANDRO_ARCH" == "arm" ]] && target="armv7a-linux-androideabi"

		clandro_download "https://github.com/termux/ghc-cross-tools/releases/download/ghc-v$CLANDRO_GHC_VERSION/ghc-$CLANDRO_GHC_VERSION-$target.tar.xz" \
			"$CLANDRO_GHC_TAR" \
			"${checksums[$CLANDRO_ARCH]}"

		mkdir -p "$CLANDRO_GHC_RUNTIME_FOLDER" "$CLANDRO_GHC_TEMP_FOLDER"
		tar -xf "$CLANDRO_GHC_TAR" -C "$CLANDRO_GHC_TEMP_FOLDER" --strip-components=1

		(
			set -e
			cd "$CLANDRO_GHC_TEMP_FOLDER"

			export CONF_CC_OPTS_STAGE2="$CFLAGS $CPPFLAGS"
			export CONF_GCC_LINKER_OPTS_STAGE2="$LDFLAGS"
			export CONF_CXX_OPTS_STAGE2="$CXXFLAGS"

			./configure \
				--prefix="$CLANDRO_GHC_RUNTIME_FOLDER" \
				--host="$target"
			make install
		) &>/dev/null

		rm -rf "$CLANDRO_GHC_TAR" "$CLANDRO_GHC_TEMP_FOLDER"
	else
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" == "apt" ]] && "$(dpkg-query -W -f '${db:Status-Status}\n' ghc 2>/dev/null)" != "installed" ||
			[[ "$CLANDRO_APP_PACKAGE_MANAGER" == "pacman" ]] && ! "$(pacman -Q ghc 2>/dev/null)"; then
			echo "Package 'ghc' is not installed."
			exit 1
		fi
	fi
}
