CLANDRO_PKG_HOMEPAGE=https://github.com/emacs-exwm/exwm
CLANDRO_PKG_DESCRIPTION="Emacs X Window Manager"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.34"
CLANDRO_PKG_SRCURL="https://github.com/emacs-exwm/exwm/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=ebe730bbda5bce75baf4532173171a9283a58684e7ec84192ba03c3d8328cf0a
CLANDRO_PKG_DEPENDS="emacs-x, emacs-xelb"
CLANDRO_PKG_RECOMMENDS="dbus"
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
	emacs -Q -batch \
		-L . -L "$CLANDRO_PREFIX/share/emacs/site-lisp/xelb" \
		-f batch-byte-compile *.el
}

clandro_step_make_install() {
	local file
	for file in *.el; do
		install -Dm644 "$file" "$CLANDRO_PREFIX/share/emacs/site-lisp/exwm/$file"
	done
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	echo "How to use EXWM:"
	echo "1. remove any preexisting manual installations of EXWM or XELB:"
	echo "  $ rm -rf ~/.emacs.d/elpa/{xelb,exwm}*"
	echo "2. put this content in '~/.emacs':"
	echo "  (require 'exwm)"
	echo "  (exwm-wm-mode)"
	echo
	echo "  In-depth configuration examples are available in the official documentation: https://github.com/emacs-exwm/exwm/wiki#bootstrap"
	echo "3. launch the X11 server with emacs as the window manager:"
	echo "  $ clandro-x11 -xstartup \"dbus-launch --exit-with-session emacs\""
	EOF
	chmod +x ./postinst
}
