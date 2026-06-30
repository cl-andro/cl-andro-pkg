CLANDRO_PKG_HOMEPAGE=https://mj.ucw.cz/sw/pciutils/
CLANDRO_PKG_DESCRIPTION="a collection of programs for inspecting and manipulating configuration of PCI devices"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.15.0"
CLANDRO_PKG_SRCURL=https://mj.ucw.cz/download/linux/pci/pciutils-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a42e6e3f76fb6b1f6ac2e08cdd151f6bf78bc4f6312c591f4b6ec197582ede3a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"

	# ${str@U} returns upper case string
	local _ARCH=${CLANDRO_ARCH@U}
	if [[ ${_ARCH} == "ARM" ]]; then
		_ARCH="ARMV7L"
	fi

	local f
	for f in config.h config.mk; do
		local in=$CLANDRO_PKG_BUILDER_DIR/${f}.in
		local out=$CLANDRO_PKG_SRCDIR/lib/${f}
		sed \
			-e 's|@CLANDRO_PKG_VERSION@|'"$CLANDRO_PKG_VERSION"'|g' \
			-e 's|@CLANDRO_ARCH@|'"${_ARCH}"'|g' \
			-e 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
			${in} > ${out}
	done
}
