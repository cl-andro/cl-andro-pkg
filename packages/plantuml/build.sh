CLANDRO_PKG_HOMEPAGE=https://plantuml.com/
CLANDRO_PKG_DESCRIPTION="Draws UML diagrams, using a simple and human readable text description"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2026.2"
CLANDRO_PKG_SRCURL="https://github.com/plantuml/plantuml/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6b359e2734f91db987900ac7b72989c1b6a878b9cab34d2af965234090599f0c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

clandro_step_make() {
	# increase gradle memory to avoid 'JVM garbage collector thrashing':
	# https://stackoverflow.com/a/74143183/11708026
	# https://github.com/termux/termux-packages/issues/24917
	$CLANDRO_PKG_SRCDIR/gradlew --no-daemon --parallel --stacktrace assemble -Dorg.gradle.jvmargs=-Xmx4096M
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/java
	install -Dm600 build/libs/plantuml-${CLANDRO_PKG_VERSION}.jar $CLANDRO_PREFIX/share/java/plantuml.jar
	install -Dm700 plantuml $CLANDRO_PREFIX/bin/
}
