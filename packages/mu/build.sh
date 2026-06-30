CLANDRO_PKG_HOMEPAGE=https://www.djcbsoftware.nl/code/mu/
CLANDRO_PKG_DESCRIPTION="Maildir indexer/searcher and Emacs client (mu4e)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.1"
CLANDRO_PKG_SRCURL="https://github.com/djcb/mu/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=9615aefcc87b87967eeccba2aaee1072c1a6c7e893ddc6f99668ef28682282a1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="emacs, fmt, glib, libc++, libxapian, libgmime"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=disabled
-Demacs=disabled
"

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		echo "(setq byte-compile-warnings nil)" > $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el
		LC_ALL=C $CLANDRO_PREFIX/bin/emacs -no-site-file -q -batch -l $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el -f batch-byte-compile $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/*.el
		rm -f $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.elc
		rm -f $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/nowarnings.el
		chmod 644 $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF

	cat <<- EOF > ./prerm
		rm -f $CLANDRO_PREFIX/share/emacs/site-lisp/mu4e/*.elc
	EOF
}
