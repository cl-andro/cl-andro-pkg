CLANDRO_PKG_HOMEPAGE=https://ziglang.org
CLANDRO_PKG_DESCRIPTION="General-purpose programming language and toolchain"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="zig/LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.0"
CLANDRO_PKG_SRCURL=https://ziglang.org/download/${CLANDRO_PKG_VERSION}/zig-bootstrap-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2a8266a4205772ef40838c8cbdf14875855a515ff3adf89b49c2d2ae93613d10
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

# clandro-elf-cleaner causes zig Segmentation Fault
CLANDRO_PKG_NO_ELF_CLEANER=true

clandro_step_post_get_source() {
	local p
	for p in "${CLANDRO_PKG_BUILDER_DIR}/${CLANDRO_PKG_VERSION}"/*.diff; do
		echo "Applying patch: $(basename "${p}")"
		sed "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" "${p}" | \
			patch --silent -p1
	done
}

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_zig

	export CLANDRO_PKG_MAKE_PROCESSES

	# zig 0.11.0+ uses 3 stages bootstrapping build system
	# for which NDK can't be used anymore
	unset AS CC CFLAGS CPP CPPFLAGS CXX CXXFLAGS LD LDFLAGS \
		PKGCONFIG PKG_CONFIG PKG_CONFIG_LIBDIR

	# todo: if zig ever builds on-device, implement whatever would work there as an else block
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PKG_CONFIG="/usr/bin/pkg-config"
	fi
}

clandro_step_make() {
	# build.patch switch to ninja to make CI build <6 hours
	./build "${ZIG_TARGET_NAME}" baseline
}

clandro_step_make_install() {
	rm -fr "${CLANDRO_PREFIX}/lib/zig"
	mkdir -p "${CLANDRO_PREFIX}/lib"
	cp -fr "out/zig-${ZIG_TARGET_NAME}-baseline" "${CLANDRO_PREFIX}/lib/zig"
	ln -fsv "../lib/zig/zig" "${CLANDRO_PREFIX}/bin/zig"
}

clandro_step_post_massage() {
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then return; fi
	if [[ -z "$(find /proc/sys/fs/binfmt_misc -type f -name 'qemu-*')" ]]; then return; fi

	( # self test
		cd "${CLANDRO_PKG_TMPDIR}" || clandro_error_exit "Failed to perform selftest for Zig $CLANDRO_PKG_VERSION"
		"$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL/lib/zig/zig" version
		"$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX_CLASSICAL/lib/zig/zig" init
	)
}
