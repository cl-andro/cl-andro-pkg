CLANDRO_PKG_HOMEPAGE="https://kristaps.bsd.lv/lowdown"
CLANDRO_PKG_DESCRIPTION="Markdown utilities and library (fork of hoedown -> sundown -> libsoldout)"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_LICENSE_FILE="LICENSE.md"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="3.0.1"
CLANDRO_PKG_SRCURL="https://kristaps.bsd.lv/lowdown/snapshots/lowdown-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ac9ea2b51c8bd59350c7bf8db5e2067e9d961b1f48d362cd8a56b022850e965c
#CLANDRO_PKG_BUILD_DEPENDS="libseccomp" ## it is merely a checkdepends for now and we dont run check during build
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_MAKE_INSTALL_TARGET="install install_libs" ## add "regress" target if one wanna run check
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	# We can not build bmake for host because it has a bmake makefile. Classic chicken and egg problem.
	DESTINATION="${CLANDRO_PKG_HOSTBUILD_DIR}/prefix" \
	clandro_download_ubuntu_packages bmake

	ln -s "${CLANDRO_PKG_HOSTBUILD_DIR}/prefix/usr/bin/bmake" "${CLANDRO_PKG_HOSTBUILD_DIR}/prefix/usr/bin/make"
}

clandro_step_configure() {
	export MAKESYSPATH="${CLANDRO_PKG_HOSTBUILD_DIR}/prefix/usr/share/bmake/mk-bmake/"
	export PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/prefix/usr/bin:${PATH}"

	## avoid hard-linking during make
	sed -Ee 's%^([\t ]*ln) -f (lowdown lowdown-diff)$%\1 -srf \2%' -i Makefile

	## not an autoconf script
	./configure \
		LDFLAGS="$LDFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		PREFIX="$CLANDRO_PREFIX" \
		MANDIR="$CLANDRO_PREFIX/share/man"
}
