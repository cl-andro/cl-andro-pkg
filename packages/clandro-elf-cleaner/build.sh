CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/clandro-elf-cleaner
CLANDRO_PKG_DESCRIPTION="Cleaner of ELF files for Android"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Please update checksum in clandro_step_start_build.sh as well if
# updating the package.
CLANDRO_PKG_VERSION=3.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-elf-cleaner/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0188b739ca890da08d5479241f37b364816ef51abe9e3e484b73fd95e42453bb
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_pre_configure() {
	sed "s%@CLANDRO_PKG_API_LEVEL@%$CLANDRO_PKG_API_LEVEL%g" \
		"$CLANDRO_PKG_BUILDER_DIR"/android-api-level.diff | patch --silent -p1
}
