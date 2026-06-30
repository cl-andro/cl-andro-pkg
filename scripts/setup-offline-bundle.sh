#!/usr/bin/env bash
##
## Download all package sources and install all build tools whether possible,
## so they will be available offline.
##

set -e -u

if [ "$(uname -o)" = "Android" ] || [ "$(uname -m)" != "x86_64" ]; then
	echo "This script supports only x86_64 GNU/Linux systems."
	exit 1
fi

export CLANDRO_SCRIPTDIR="$(dirname "$(readlink -f "$0")")/../"
mkdir -p "$CLANDRO_SCRIPTDIR"/build-tools

. "$CLANDRO_SCRIPTDIR"/scripts/properties.sh
: "${CLANDRO_PKG_MAKE_PROCESSES:="$(nproc)"}"
export CLANDRO_PKG_MAKE_PROCESSES
export CLANDRO_PACKAGES_OFFLINE=true
export CLANDRO_ARCH=aarch64
export CLANDRO_ON_DEVICE_BUILD=false
export CLANDRO_PKG_TMPDIR="$CLANDRO_SCRIPTDIR/build-tools/_tmp"
export CLANDRO_COMMON_CACHEDIR="$CLANDRO_PKG_TMPDIR"
export CLANDRO_HOST_PLATFORM=aarch64-linux-android
export CLANDRO_ARCH_BITS=64
export CLANDRO_BUILD_TUPLE=x86_64-pc-linux-gnu
export CLANDRO_PKG_API_LEVEL=24
export CLANDRO_TOPDIR="$HOME/.clandro-build"
export CLANDRO_PYTHON_CROSSENV_PREFIX="$CLANDRO_TOPDIR/python-crossenv-prefix"
export CLANDRO_PYTHON_VERSION=$(. "$CLANDRO_SCRIPTDIR/packages/python/build.sh"; echo "$_MAJOR_VERSION")
export CLANDRO_PYTHON_HOME=$CLANDRO_PREFIX/lib/python${CLANDRO_PYTHON_VERSION}
export CC=gcc CXX=g++ LD=ld AR=ar STRIP=strip PKG_CONFIG=pkg-config
export CPPFLAGS="" CFLAGS="" CXXFLAGS="" LDFLAGS=""
export CLANDRO_PACKAGE_LIBRARY=bionic
mkdir -p "$CLANDRO_PKG_TMPDIR"

# Build tools.
. "$CLANDRO_SCRIPTDIR"/scripts/build/clandro_download.sh
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_cargo_c.sh
	clandro_setup_cargo_c
)
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_cmake.sh
	clandro_setup_cmake
)
# GHC fails. Skipping for now.
#(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_ghc.sh
#	clandro_setup_ghc
#)
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_golang.sh
	clandro_setup_golang
)
(
	. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_ninja.sh
	. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_meson.sh
	clandro_setup_meson
)
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_protobuf.sh
	clandro_setup_protobuf
)
#(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_python_pip.sh
#	clandro_setup_python_pip
#)
# Offline rust is not supported yet.
#(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_rust.sh
#	clandro_setup_rust
#)
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_swift.sh
	clandro_setup_swift
)
(. "$CLANDRO_SCRIPTDIR"/scripts/build/setup/clandro_setup_zig.sh
	clandro_setup_zig
)
(test -d "$CLANDRO_SCRIPTDIR"/build-tools/android-sdk && test -d "$CLANDRO_SCRIPTDIR"/build-tools/android-ndk && exit 0
	"$CLANDRO_SCRIPTDIR"/scripts/setup-android-sdk.sh
)
rm -rf "${CLANDRO_PKG_TMPDIR}"

# Package sources.
for repo_path in $(jq --raw-output 'del(.pkg_format) | keys | .[]' $CLANDRO_SCRIPTDIR/repo.json); do
	for p in "$CLANDRO_SCRIPTDIR"/$repo_path/*; do
		(
			. "$CLANDRO_SCRIPTDIR"/scripts/build/get_source/clandro_step_get_source.sh
			. "$CLANDRO_SCRIPTDIR"/scripts/build/get_source/clandro_git_clone_src.sh
			. "$CLANDRO_SCRIPTDIR"/scripts/build/get_source/clandro_download_src_archive.sh
			. "$CLANDRO_SCRIPTDIR"/scripts/build/get_source/clandro_unpack_src_archive.sh

			# Disable archive extraction in clandro_step_get_source.sh.
			clandro_extract_src_archive() {
				:
			}

			CLANDRO_PKG_NAME=$(basename "$p")
			CLANDRO_PKG_BUILDER_DIR="${p}"
			CLANDRO_PKG_CACHEDIR="${p}/cache"
			CLANDRO_PKG_METAPACKAGE=false

			# Set some variables to dummy values to avoid errors.
			CLANDRO_PKG_TMPDIR="${CLANDRO_PKG_CACHEDIR}/.tmp"
			CLANDRO_PKG_SRCDIR="${CLANDRO_PKG_CACHEDIR}/.src"
			CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
			CLANDRO_PKG_HOSTBUILD_DIR="$CLANDRO_PKG_TMPDIR"
			CLANDRO_PKG_GIT_BRANCH=""
			CLANDRO_DEBUG_BUILD=false


			mkdir -p "$CLANDRO_PKG_CACHEDIR" "$CLANDRO_PKG_TMPDIR" "$CLANDRO_PKG_SRCDIR"
			cd "$CLANDRO_PKG_CACHEDIR"

			. "${p}"/build.sh || true
			if ! ${CLANDRO_PKG_METAPACKAGE}; then
				echo "Downloading sources for '$CLANDRO_PKG_NAME'..."
				clandro_step_get_source

				# Delete dummy src and tmp directories.
				rm -rf "$CLANDRO_PKG_TMPDIR" "$CLANDRO_PKG_SRCDIR"
			fi
		)
	done
done

# Mark to tell build-package.sh to enable offline mode.
touch "$CLANDRO_SCRIPTDIR"/build-tools/.installed
