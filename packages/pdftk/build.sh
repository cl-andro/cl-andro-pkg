CLANDRO_PKG_HOMEPAGE=https://gitlab.com/pdftk-java/pdftk
CLANDRO_PKG_DESCRIPTION="A simple tool for doing everyday things with PDF documents"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.3"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://gitlab.com/pdftk-java/pdftk/-/archive/v${CLANDRO_PKG_VERSION}/pdftk-v${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=c144e0dd388db2f5e8e0b412c0d9be6c54e4db99a4575b6058a209f3603a333d
CLANDRO_PKG_DEPENDS="libbcprov-java, libcommons-lang3-java, openjdk-21"
CLANDRO_PKG_BUILD_DEPENDS="ant"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	mkdir -p lib
	ln -sf $CLANDRO_PREFIX/share/java/commons-lang3.jar lib/
	ln -sf $CLANDRO_PREFIX/share/java/bcprov.jar lib/
}

clandro_step_make() {
	sh $CLANDRO_PREFIX/bin/ant jar
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/java
	install -Dm600 build/jar/pdftk.jar $CLANDRO_PREFIX/share/java/
	install -Dm700 pdftk $CLANDRO_PREFIX/bin/
}
