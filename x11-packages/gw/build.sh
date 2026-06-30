CLANDRO_PKG_HOMEPAGE=https://github.com/kcleal/gw
CLANDRO_PKG_DESCRIPTION="A browser for genomic sequencing data (.bam/.cram format)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="clealk@cardiff.ac.uk"
CLANDRO_PKG_VERSION="1.2.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/kcleal/gw/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4ab7afc7c8785f956e9ee32c984a5f69c4671d3025d53493a5cd9e295701dad0
CLANDRO_PKG_DEPENDS="glfw, htslib, libc++, libjpeg-turbo, opengl, libcurl"
CLANDRO_PKG_BUILD_DEPENDS="fontconfig, freetype, libicu, libuuid, mesa-dev, libcurl"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

# htslib is not available for arm.
CLANDRO_PKG_EXCLUDED_ARCHES="arm"

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"

	sed -i \
		-e '/\/usr\/local\/include/d' \
		-e '/\/usr\/local\/lib/d' \
		./Makefile

	if [ "$CLANDRO_ARCH" = "aarch64" ]; then
		sed -i 's/Release-x64/Release-arm64/g' ./Makefile
	elif [ "$CLANDRO_ARCH" = "i686" ]; then
		sed -i 's/Release-x64/Release-x86/g' ./Makefile
	fi
}

clandro_step_make() {
	local SKIA_URL_AARCH64="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-arm64.zip"
	local SKIA_CHECKSUM_AARCH64="7286fe634cfcd499ef1232b9bdc6b08220daebde0de483639ed498a1dc1ec62e"
	local SKIA_URL_X86="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-x86.zip"
	local SKIA_CHECKSUM_X86="e79868a2b791ec44673f981b68d5cb658dad3fcef97932ac7b4a80c3dd329e87"
	local SKIA_URL_X64="https://github.com/JetBrains/skia-build/releases/download/m93-87e8842e8c/Skia-m93-87e8842e8c-android-Release-x64.zip"
	local SKIA_CHECKSUM_X64="1546e41c0b2edc401639e1ed0dd32d9e8b30d478f1c4a5c345ee82f2a5e1b829"

	mkdir -p lib/skia && cd lib/skia/
	case "$CLANDRO_ARCH" in
		aarch64)
			clandro_download "$SKIA_URL_AARCH64" "${CLANDRO_PKG_CACHEDIR}/skia-${CLANDRO_ARCH}.zip" "$SKIA_CHECKSUM_AARCH64"
			;;
		i686)
			clandro_download "$SKIA_URL_X86" "${CLANDRO_PKG_CACHEDIR}/skia-${CLANDRO_ARCH}.zip" "$SKIA_CHECKSUM_X86"
			;;
		x86_64)
			clandro_download "$SKIA_URL_X64" "${CLANDRO_PKG_CACHEDIR}/skia-${CLANDRO_ARCH}.zip" "$SKIA_CHECKSUM_X64"
			;;
		*)
			clandro_error_exit "No architecture '$CLANDRO_ARCH' defined for Skia download."
			;;
	esac
	unzip -o "${CLANDRO_PKG_CACHEDIR}/skia-${CLANDRO_ARCH}.zip"
	cd ../../

	OLD_SKIA=1 make -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}/bin" ./gw
	install -Dm600 ./.gw.ini "${CLANDRO_PREFIX}/share/doc/gw/gw.ini"
}
