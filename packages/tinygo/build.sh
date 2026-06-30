CLANDRO_PKG_HOMEPAGE=https://tinygo.org
CLANDRO_PKG_DESCRIPTION="Go compiler for microcontrollers, WASM, CLI tools"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.41.1"
CLANDRO_PKG_SRCURL=git+https://github.com/tinygo-org/tinygo
CLANDRO_PKG_GIT_BRANCH="v${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_SHA256=312536239888b84fb217a8c9d63da526374e3475e4abb5bd2ad98a077dab638b
CLANDRO_PKG_DEPENDS="binaryen, golang, libc++"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="binaryen, golang"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
_LLVM_OPTION="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DGENERATOR_IS_MULTI_CONFIG=ON
-DLLVM_TABLEGEN=${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-tblgen
-DCLANG_TABLEGEN=${CLANDRO_PKG_HOSTBUILD_DIR}/bin/clang-tblgen
"
_LLVM_EXTRA_BUILD_TARGETS="
lib/libLLVMDWARFLinker.a
lib/libLLVMDWARFLinkerClassic.a
lib/libLLVMDWARFLinkerParallel.a
lib/libLLVMDWP.a
lib/libLLVMDebugInfoGSYM.a
lib/libLLVMDebugInfoLogicalView.a
lib/libLLVMFileCheck.a
lib/libLLVMFrontendOpenACC.a
lib/libLLVMFuzzMutate.a
lib/libLLVMFuzzerCLI.a
lib/libLLVMInterfaceStub.a
lib/libLLVMJITLink.a
lib/libLLVMLineEditor.a
lib/libLLVMMIRParser.a
lib/libLLVMObjCopy.a
lib/libLLVMObjectYAML.a
lib/libLLVMOrcDebugging.a
lib/libLLVMOrcJIT.a
lib/libLLVMTelemetry.a
lib/libLLVMTextAPIBinaryReader.a
lib/libLLVMSandboxIR.a
lib/libLLVMXRay.a
"

clandro_pkg_auto_update() {
	local e=0
	local latest_tag
	latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}" "${CLANDRO_PKG_UPDATE_TAG_TYPE}")"
	# shellcheck disable=SC2001 # We need to manually strip the tag prefix from the tag.
	latest_tag="$(sed -e "s/^[^0-9]*//" <<< "${latest_tag}")"
	if [[ "${latest_tag}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi
	[[ -z "${latest_tag}" ]] && e=1

	local uptime_now
	uptime_now="$(< /proc/uptime)"
	local uptime_s="${uptime_now//.*}"
	local uptime_h_limit=1
	local uptime_s_limit=$((uptime_h_limit*60*60))
	[[ -z "${uptime_s}" ]] && [[ "$(uname -o)" != "Android" ]] && e=1
	[[ "${uptime_s}" == 0 ]] && [[ "$(uname -o)" != "Android" ]] && e=1
	[[ "${uptime_s}" -gt "${uptime_s_limit}" ]] && e=1

	if [[ "${e}" != 0 ]]; then
		cat <<- EOL >&2
		WARN: Auto update failure!
		latest_tag=${latest_tag}
		uptime_now=${uptime_now}
		uptime_s=${uptime_s}
		uptime_s_limit=${uptime_s_limit}
		EOL
		return
	fi

	local tmpdir
	tmpdir="$(mktemp -d)"
	git clone --branch "v${latest_tag}" --depth=1 --recursive \
		"${CLANDRO_PKG_SRCURL#git+}" "${tmpdir}"
	make -C "${tmpdir}" llvm-source GO=:
	local s
	s="$(
		find "${tmpdir}" -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | \
		cut -d" " -f1 | LC_ALL=C sort | sha256sum | cut -d" " -f1
	)"

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_tag}."
		return
	fi

	sed \
		-e "s|^CLANDRO_PKG_SHA256=.*|CLANDRO_PKG_SHA256=${s}|" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	rm -fr "${tmpdir}"

	echo "INFO: Generated checksum: ${s}"
	clandro_pkg_upgrade_version "${latest_tag}"
}

clandro_step_post_get_source() {
	# https://github.com/tinygo-org/tinygo/blob/release/Makefile
	# https://github.com/espressif/llvm-project
	make llvm-source GO=:

	local s=$(
		find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | \
		cut -d" " -f1 | LC_ALL=C sort | sha256sum | cut -d" " -f1
	)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}" ]]; then
		clandro_error_exit "
		Checksum mismatch for source files!
		Expected = ${CLANDRO_PKG_SHA256}
		Actual   = ${s}
		"
	fi
}

clandro_step_host_build() {
	clandro_setup_golang
	clandro_setup_cmake
	clandro_setup_ninja

	pushd "${CLANDRO_PKG_SRCDIR}"
	make "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		LLVM_BUILDDIR="${CLANDRO_PKG_HOSTBUILD_DIR}"

	# build whatever llvm-config think is missing
	ninja \
		-C "${CLANDRO_PKG_HOSTBUILD_DIR}" \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" \
		${_LLVM_EXTRA_BUILD_TARGETS}

	echo "INFO: ========== llvm-config =========="
	file "${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-config"
	"${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-config" --cppflags
	"${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-config" --ldflags --libs --system-libs
	echo "INFO: ========== llvm-config =========="

	make build/release \
		LLVM_BUILDDIR="${CLANDRO_PKG_HOSTBUILD_DIR}" \
		CLANG="${CLANDRO_PKG_HOSTBUILD_DIR}/bin/clang" \
		LLVM_AR="${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-ar" \
		LLVM_NM="${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-nm" \
		USE_SYSTEM_BINARYEN=1
	popd
}

clandro_step_pre_configure() {
	# this is a workaround for build-all.sh issue
	CLANDRO_PKG_DEPENDS+=", tinygo-common"

	# https://github.com/termux/termux-packages/issues/16358
	if [[ "${CLANDRO_ON_DEVICE_BUILD}" == "true" ]]; then
		echo "WARN: ld.lld wrapper is not working for on-device builds. Skipping."
		return
	fi

	local _WRAPPER_BIN=${CLANDRO_PKG_BUILDDIR}/_wrapper/bin
	mkdir -p "${_WRAPPER_BIN}"
	ln -fs "${CLANDRO_STANDALONE_TOOLCHAIN}/bin/lld" "${_WRAPPER_BIN}/ld.lld"
	cat <<- EOF > "${_WRAPPER_BIN}/ld.lld.sh"
	#!/bin/bash
	tmpfile=\$(mktemp)
	python ${CLANDRO_PKG_BUILDER_DIR}/fix-rpath.py -rpath=${CLANDRO_PREFIX}/lib \$@ > \${tmpfile}
	args=\$(cat \${tmpfile})
	rm -f \${tmpfile}
	${_WRAPPER_BIN}/ld.lld \${args}
	EOF
	chmod +x "${_WRAPPER_BIN}/ld.lld.sh"
	rm -f "${CLANDRO_STANDALONE_TOOLCHAIN}/bin/ld.lld"
	ln -fs "${_WRAPPER_BIN}/ld.lld.sh" "${CLANDRO_STANDALONE_TOOLCHAIN}/bin/ld.lld"
}

clandro_step_make() {
	clandro_setup_golang
	clandro_setup_cmake
	clandro_setup_ninja

	# from packages/libllvm/build.sh
	local _LLVM_TARGET_TRIPLE=${CLANDRO_HOST_PLATFORM/-/-unknown-}${CLANDRO_PKG_API_LEVEL}
	local _LLVM_TARGET_ARCH
	case "${CLANDRO_ARCH}" in
	aarch64) _LLVM_TARGET_ARCH="AArch64" ;;
	arm) _LLVM_TARGET_ARCH="ARM" ;;
	i686|x86_64) _LLVM_TARGET_ARCH="X86" ;;
	*) clandro_error_exit "Invalid arch: ${CLANDRO_ARCH}" ;;
	esac
	_LLVM_OPTION+="
	-DLLVM_HOST_TRIPLE=${_LLVM_TARGET_TRIPLE}
	-DLLVM_TARGET_ARCH=${_LLVM_TARGET_ARCH}
	"

	make llvm-build LLVM_OPTION="$(echo ${_LLVM_OPTION})"

	ninja \
		-C llvm-build \
		-j "${CLANDRO_PKG_MAKE_PROCESSES}" \
		${_LLVM_EXTRA_BUILD_TARGETS}

	# replace Android llvm-config with wrapper around host build
	cat <<- EOF > llvm-build/bin/llvm-config
	#!/bin/bash
	${CLANDRO_PKG_HOSTBUILD_DIR}/bin/llvm-config "\$@" | \
	sed \
	-e "s|${CLANDRO_PKG_HOSTBUILD_DIR}|${CLANDRO_PKG_SRCDIR}/llvm-build|g" \
	-e "s|-lrt|-lc|g"
	EOF

	make tinygo
	mkdir -p build/release/tinygo/bin
	cp -fv build/tinygo build/release/tinygo/bin

	# skip make gen-device, done in host build
	# skip make wasi-libc, NDK doesnt support wasm32-unknown-wasi
	# skip make binaryen

	# check excessive runpath entries
	local tinygo_readelf=$(readelf -dW build/release/tinygo/bin/tinygo)
	local tinygo_runpath=$(echo "${tinygo_readelf}" | sed -ne "s|.*RUNPATH.*\[\(.*\)\].*|\1|p")
	if [[ "${tinygo_runpath}" != "${CLANDRO_PREFIX}/lib" ]]; then
		clandro_error_exit "
		Excessive RUNPATH found. Check readelf output below:
		${tinygo_readelf}
		"
	fi
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/lib/tinygo"
	cp -fr "${CLANDRO_PKG_SRCDIR}/build/release/tinygo" "${CLANDRO_PREFIX}/lib"
	ln -fsv "../lib/tinygo/bin/tinygo" "${CLANDRO_PREFIX}/bin/tinygo"
}
