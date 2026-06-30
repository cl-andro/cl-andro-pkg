# Contributor: @0x1ACA663
CLANDRO_PKG_HOMEPAGE=https://dart.dev/
CLANDRO_PKG_DESCRIPTION="Dart is a general-purpose programming language"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE=sdk/LICENSE
CLANDRO_PKG_MAINTAINER=@0x1ACA663
CLANDRO_PKG_VERSION="3.11.6"
CLANDRO_PKG_SRCURL=https://github.com/dart-lang/sdk/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=107d24efcf88be96ceea9045465bc4c6f90a230d09b48511a45447145db01946
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXCLUDED_ARCHES=i686

clandro_pkg_auto_update() {
	curl --fail --location --show-error --silent --output VERSION \
		https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION
	local version=$(jq --raw-output .version VERSION)
	rm --force VERSION

	case ${version} in
		null) clandro_error_exit "Failed to get latest version." ;;
		${CLANDRO_PKG_VERSION}) echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'." ;;
		*) clandro_pkg_upgrade_version ${version} ;;
	esac
}

clandro_step_get_source() {
	mkdir --parents ${CLANDRO_PKG_SRCDIR}
	cd ${CLANDRO_PKG_SRCDIR}

	git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
	export PATH="${PWD}/depot_tools:${PATH}"

	local src_url=https://dart.googlesource.com/sdk.git
	git clone --branch ${CLANDRO_PKG_VERSION} --depth 1 --no-tags ${src_url}
	gclient config \
		--name sdk \
		--custom-var download_android_deps=True \
		--unmanaged \
		${src_url}

	gclient sync
}

clandro_step_make_install() {
	local arch
	case ${CLANDRO_ARCH} in
		arm) arch=arm ;;
		aarch64) arch=arm64 ;;
		x86_64) arch=x64 ;;
		*) clandro_error_exit "Unsupported arch '${CLANDRO_ARCH}'" ;;
	esac

	cd sdk
	./tools/build.py --no-rbe --arch ${arch} --mode release --os android create_sdk
	mv ./out/ReleaseAndroid${arch^^}/dart-sdk ${CLANDRO_PREFIX}/lib
}

clandro_step_post_make_install() {
	for file in ${CLANDRO_PREFIX}/lib/dart-sdk/bin/*; do
		if [[ -f ${file} && -x ${file} ]]; then
			local wrapper_exe=${CLANDRO_PREFIX}/bin/$(basename ${file})
			printf '#!%s/bin/sh\nexec %s "$@"\n' ${CLANDRO_PREFIX} ${file} > ${wrapper_exe}
			chmod +x ${wrapper_exe}
		fi
	done

	local dart_internal=${CLANDRO_PREFIX}/lib/dart-sdk/lib/_internal
	rm --force ${dart_internal}/vm_platform_strong.dill
	ln --symbolic ${dart_internal}/vm_platform.dill ${dart_internal}/vm_platform_strong.dill

	install -D --mode 600 \
		${CLANDRO_PKG_BUILDER_DIR}/dart-pub-bin.sh \
		${CLANDRO_PREFIX}/etc/profile.d/dart-pub-bin.sh
}
