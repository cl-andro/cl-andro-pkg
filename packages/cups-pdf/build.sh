CLANDRO_PKG_HOMEPAGE=https://www.cups-pdf.de/
CLANDRO_PKG_DESCRIPTION="CUPS PDF backend"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://www.cups-pdf.de/src/cups-pdf_${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=738669edff7f1469fe5e411202d87f93ba25b45f332a623fb607d49c59aa9531
CLANDRO_PKG_DEPENDS="cups, ghostscript"
CLANDRO_PKG_CONFFILES="etc/cups/cups-pdf.conf"

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS $CLANDRO_PKG_SRCDIR/src/cups-pdf.c \
		-o cups-pdf $LDFLAGS -lcups
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/lib/cups/backend \
		cups-pdf
	install -Dm600 -t $CLANDRO_PREFIX/etc/cups \
		$CLANDRO_PKG_SRCDIR/extra/cups-pdf.conf
	install -Dm600 -t $CLANDRO_PREFIX/share/cups/model \
		$CLANDRO_PKG_SRCDIR/extra/CUPS-PDF_opt.ppd
}
