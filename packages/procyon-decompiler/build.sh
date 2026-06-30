CLANDRO_PKG_HOMEPAGE=https://github.com/mstrobel/procyon
CLANDRO_PKG_DESCRIPTION="A standalone front-end for the Java decompiler in Procyon Compiler Toolset"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/mstrobel/procyon/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=516f410868f7523d804362a9dff5fa8fcf9232e5ee36bb7f0a5c8f71d5de7fe4
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	./gradlew build -x test -x javadoc
}

clandro_step_make_install() {
	install -Dm600 -T \
		./build/Procyon.Decompiler/libs/procyon-decompiler-${CLANDRO_PKG_VERSION}.jar \
		$CLANDRO_PREFIX/share/java/procyon-decompiler.jar
	install -Dm700 -t $CLANDRO_PREFIX/bin procyon-decompiler
}
