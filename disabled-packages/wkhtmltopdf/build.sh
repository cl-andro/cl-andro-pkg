CLANDRO_PKG_HOMEPAGE=https://wkhtmltopdf.org/
CLANDRO_PKG_DESCRIPTION="wkhtmltopdf and wkhtmltoimage are command line tools to render HTML into PDF and various image formats using the QT Webkit rendering engine."
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION=0.12.6
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/wkhtmltopdf/wkhtmltopdf/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=adcced78492e7366d940c66a1327a85d3ae8c45190f486f545fdaa84cac662f0
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, qt5-qtwebkit, qt5-qtxmlpatterns"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
}

clandro_step_make_install () {
	cd ${CLANDRO_PKG_SRCDIR}/bin
	install -Dm700 -t ${CLANDRO_PREFIX}/lib ./*.so*
	install -Dm700 -t ${CLANDRO_PREFIX}/bin ./wkhtmltoimage ./wkhtmltopdf
}
