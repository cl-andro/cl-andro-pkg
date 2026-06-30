CLANDRO_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
CLANDRO_PKG_DESCRIPTION="Bootstrap a basic Debian system"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="debian/copyright"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.0.143"
CLANDRO_PKG_SRCURL="https://deb.debian.org/debian/pool/main/d/debootstrap/debootstrap_${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=c638730e50d3cd8a46ff4ce8b1f74d579e9c8323974285cf3fd1ac36aa8f2ade
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="llvm, perl, proot, sed, wget"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	:
}

clandro_step_make_install() {
	find ${CLANDRO_PKG_SRCDIR}/.. -name "*.orig" -delete

	local VERSION=$(sed 's/.*(\(.*\)).*/\1/; q' debian/changelog)
	mkdir -p ${CLANDRO_PREFIX}/share/debootstrap/scripts
	cp -a scripts/* ${CLANDRO_PREFIX}/share/debootstrap/scripts/
	install -m 0644 functions ${CLANDRO_PREFIX}/share/debootstrap/
	sed "s/@VERSION@/${VERSION}/g" debootstrap > ${CLANDRO_PREFIX}/bin/debootstrap
	chmod 0755 ${CLANDRO_PREFIX}/bin/debootstrap

	mkdir -p ${CLANDRO_PREFIX}/share/man/man8/
	install ${CLANDRO_PKG_SRCDIR}/debootstrap.8 ${CLANDRO_PREFIX}/share/man/man8/
}
