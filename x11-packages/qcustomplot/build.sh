CLANDRO_PKG_HOMEPAGE=https://www.qcustomplot.com/
CLANDRO_PKG_DESCRIPTION="A Qt C++ widget for plotting and data visualization"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=(https://www.qcustomplot.com/release/${CLANDRO_PKG_VERSION}/QCustomPlot-source.tar.gz
                   https://www.qcustomplot.com/release/${CLANDRO_PKG_VERSION}/QCustomPlot-sharedlib.tar.gz)
CLANDRO_PKG_SHA256=(5e2d22dec779db8f01f357cbdb25e54fbcf971adaee75eae8d7ad2444487182f
                   35d6ea9c7e8740edf0b37e2cb6aa6794150d0dde2541563e493f3f817012b4c0)
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
CONFIG+=shared
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/qcustomplot-sharedlib/sharedlib-compilation"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
}

clandro_step_configure() {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}

clandro_step_make_install() {
	local f
	for f in libqcustomplot.so*; do
		if test -L "${f}"; then
			ln -sf "$(readlink "${f}")" $CLANDRO_PREFIX/lib/"${f}"
		else
			install -Dm600 -t $CLANDRO_PREFIX/lib "${f}"
		fi
	done
	install -Dm600 -t $CLANDRO_PREFIX/include ../../qcustomplot.h
}
