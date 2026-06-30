CLANDRO_PKG_HOMEPAGE=https://github.com/emacs-exwm/xelb
CLANDRO_PKG_DESCRIPTION="X protocol Emacs Lisp Binding"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.19"
CLANDRO_PKG_SRCURL="https://github.com/emacs-exwm/xelb/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=b518d4b74f41eaa104d389f77d9fe90eb1b99031d6afd7ba5a9dfd5dd49af112
CLANDRO_PKG_DEPENDS="emacs-x"
CLANDRO_PKG_BUILD_DEPENDS="xcb-proto"
CLANDRO_PKG_AUTO_UPDATE=true
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
}

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/EMACS/bin:${PATH}"
	fi
}

clandro_step_make() {
	# does not work properly with -j "$CLANDRO_PKG_MAKE_PROCESSES"
	make PROTO_PATH="$CLANDRO_PREFIX/share/xcb"
	emacs -Q -batch -L . -f batch-byte-compile *.el
}

clandro_step_make_install() {
	local file
	for file in *.el; do
		install -Dm644 "$file" "$CLANDRO_PREFIX/share/emacs/site-lisp/xelb/$file"
	done
}
