CLANDRO_PKG_HOMEPAGE=https://www.jython.org/
CLANDRO_PKG_DESCRIPTION="Python for the Java Platform"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/jython/jython/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=36a4bab0cf02eb6c5169d7e818531f321e276f17111833540db7d19150d3e5b2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_BUILD_DEPENDS="ant"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_RM_AFTER_INSTALL="
opt/jython/bin/jython_regrtest.bat
opt/jython/bin/jython.exe
opt/jython/bin/jython.py
"

clandro_step_make() {
	sh $CLANDRO_PREFIX/bin/ant
}

clandro_step_make_install() {
	rm -rf $CLANDRO_PREFIX/opt/jython
	mkdir -p $CLANDRO_PREFIX/opt/jython
	cp -a $CLANDRO_PKG_SRCDIR/dist/* $CLANDRO_PREFIX/opt/jython/
	ln -sfr $CLANDRO_PREFIX/opt/jython/bin/jython $CLANDRO_PREFIX/bin/jython
}
