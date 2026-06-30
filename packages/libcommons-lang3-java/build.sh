CLANDRO_PKG_HOMEPAGE=https://commons.apache.org/proper/commons-lang/
CLANDRO_PKG_DESCRIPTION="A host of helper utilities for the java.lang API"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.20.0"
CLANDRO_PKG_SRCURL=https://dlcdn.apache.org/commons/lang/source/commons-lang3-${CLANDRO_PKG_VERSION}-src.tar.gz
CLANDRO_PKG_SHA256=ca736b78a140fdc83a8d23572ad0521a30d0239c5f8c7ddcb7cbf8c0abfb6215
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	cd src/main/java
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	_BUILD_JARFILE="$CLANDRO_PKG_BUILDDIR/commons-lang3.jar"
	rm -f "$_BUILD_JARFILE"
	jar cf "$_BUILD_JARFILE" $(find . -name "*.class")
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $CLANDRO_PREFIX/share/java/
}
