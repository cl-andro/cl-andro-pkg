# shellcheck shell=bash
# This provides an utility to run binaries under clandro environment via proot.
clandro_setup_proot() {
	local CLANDRO_PROOT_VERSION=5.3.0
	local CLANDRO_QEMU_VERSION=7.2.0-1
	local CLANDRO_PROOT_BIN="$CLANDRO_COMMON_CACHEDIR/proot-bin-$CLANDRO_ARCH"
	local CLANDRO_PROOT_QEMU=""
	local CLANDRO_PROOT_BIN_NAME="clandro-proot-run"

	export PATH="$CLANDRO_PROOT_BIN:$PATH"

	[[ -d "$CLANDRO_PROOT_BIN" ]] && return

	if ! [[ -d "$CLANDRO_PREFIX/opt/aosp" ]]; then
		echo "ERROR: Add 'aosp-libs' to CLANDRO_PKG_BUILD_DEPENDS. 'proot' cannot run without it."
		exit 1
	fi

	mkdir -p "$CLANDRO_PROOT_BIN"

	clandro_download https://github.com/proot-me/proot/releases/download/v"$CLANDRO_PROOT_VERSION"/proot-v"$CLANDRO_PROOT_VERSION"-x86_64-static \
		"$CLANDRO_PROOT_BIN/proot" \
		d1eb20cb201e6df08d707023efb000623ff7c10d6574839d7bb42d0adba6b4da
	chmod +x "$CLANDRO_PROOT_BIN"/proot

	declare -A checksums=(
		["aarch64"]="dce64b2dc6b005485c7aa735a7ea39cb0006bf7e5badc28b324b2cd0c73d883f"
		["arm"]="9f07762a3cd0f8a199cb5471a92402a4765f8e2fcb7fe91a87ee75da9616a806"
	)
	if [[ "$CLANDRO_ARCH" == "aarch64" ]] || [[ "$CLANDRO_ARCH" == "arm" ]]; then
		clandro_download https://github.com/multiarch/qemu-user-static/releases/download/v"$CLANDRO_QEMU_VERSION"/qemu-"${CLANDRO_ARCH/i686/i386}"-static \
			"$CLANDRO_PROOT_BIN"/qemu-"$CLANDRO_ARCH" \
			"${checksums[$CLANDRO_ARCH]}"
		chmod +x "$CLANDRO_PROOT_BIN"/qemu-"$CLANDRO_ARCH"
		CLANDRO_PROOT_QEMU="-q $CLANDRO_PROOT_BIN/qemu-$CLANDRO_ARCH"
	fi

	# NOTE: We include current PATH too so that host binaries also become available under proot.
	cat <<-EOF >"$CLANDRO_PROOT_BIN/$CLANDRO_PROOT_BIN_NAME"
		#!/bin/bash
		env -i \
			PATH="$CLANDRO_PREFIX/bin:$PATH" \
			ANDROID_DATA=/data \
			ANDROID_ROOT=/system \
			HOME=$CLANDRO_ANDROID_HOME \
			LANG=en_US.UTF-8 \
			PREFIX=$CLANDRO_PREFIX \
			TERM=$TERM \
			TZ=UTC \
			$CLANDRO_PROOT_EXTRA_ENV_VARS \
			$CLANDRO_PROOT_BIN/proot $CLANDRO_PROOT_QEMU -R / "\$@"
	EOF
	chmod +x "$CLANDRO_PROOT_BIN/$CLANDRO_PROOT_BIN_NAME"
}
