CLANDRO_PKG_HOMEPAGE=https://notmuchmail.org
CLANDRO_PKG_DESCRIPTION="Thread-based email index, search and tagging system"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.40"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://notmuchmail.org/releases/notmuch-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4b4314bbf1c2029fdf793637e6c7bb15c1b1730d22be9aa04803c98c5bbc446f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libc++, libgmime, libtalloc, libxapian, zlib"
CLANDRO_PKG_BUILD_DEPENDS="emacs"
CLANDRO_PKG_RECOMMENDS="emacs"
CLANDRO_PKG_BREAKS="notmuch-dev"
CLANDRO_PKG_REPLACES="notmuch-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	EMACS_SRCURL=https://mirrors.kernel.org/gnu/emacs/emacs-30.2.tar.xz
	EMACS_SHA256=b3f36f18a6dd2715713370166257de2fae01f9d38cfe878ced9b1e6ded5befd9
	EMACS_ARCHIVE="${CLANDRO_PKG_CACHEDIR}/EMACS.tar.xz"
	EMACS_WORKDIR="${CLANDRO_PKG_TMPDIR}/EMACS"
	EMACS_INSTALLDIR="${CLANDRO_PKG_HOSTBUILD_DIR}/EMACS"
	mkdir -p "${EMACS_WORKDIR}" "${EMACS_INSTALLDIR}"
	clandro_download "$EMACS_SRCURL" "$EMACS_ARCHIVE" "$EMACS_SHA256"
	tar xf "${CLANDRO_PKG_CACHEDIR}/EMACS.tar.xz" --strip-components=1 -C "${EMACS_WORKDIR}"
	pushd "${EMACS_WORKDIR}"
	./configure \
		--without-xpm \
		--without-gif \
		--without-gnutls \
		--prefix="${EMACS_INSTALLDIR}"
	make -j"$CLANDRO_PKG_MAKE_PROCESSES"
	make install
	popd

	clandro_download_ubuntu_packages install-info
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/EMACS/bin:${PATH}"
		export PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages/usr/bin:${PATH}"
	fi
}

clandro_step_configure() {
	# Use python3 so that the python3-sphinx package is
	# found for man page generation.
	export PYTHON=python3

	cd $CLANDRO_PKG_SRCDIR
	XAPIAN_CONFIG=$CLANDRO_PREFIX/bin/xapian-config ./configure \
		--prefix=$CLANDRO_PREFIX \
		--without-api-docs \
		--without-desktop \
		--with-emacs \
		--emacslispdir="$CLANDRO_PREFIX/share/emacs/site-lisp/notmuch" \
		--emacsetcdir="$CLANDRO_PREFIX/share/emacs/site-lisp/notmuch" \
		--without-ruby
}
