CLANDRO_PKG_HOMEPAGE=https://www.bouncycastle.org/java.html
CLANDRO_PKG_DESCRIPTION="A lightweight cryptography API for Java"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.html"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.84"
CLANDRO_PKG_SRCURL=https://github.com/bcgit/bc-java/archive/refs/tags/r${CLANDRO_PKG_VERSION/./rv}.tar.gz
CLANDRO_PKG_SHA256=4883bfc4a697a35e5fa6c6ec95df6d0b90ee6e3d2418304f1ae3c017fa14af6a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP='s/rv/./;s/r//'
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	cd prov
	local src_dirs="src/main/java ../core/src/main/java"
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find $src_dirs -name "*.java")
	_BUILD_JARFILE="$CLANDRO_PKG_BUILDDIR/bcprov.jar"
	rm -f "$_BUILD_JARFILE"
	for d in $src_dirs; do
		local jar_op=u
		if [ ! -e "$_BUILD_JARFILE" ]; then
			jar_op=c
		fi
		pushd $d
		jar ${jar_op}f "$_BUILD_JARFILE" $(find . -name "*.class")
		popd
	done
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/java
	install -Dm600 "$_BUILD_JARFILE" $CLANDRO_PREFIX/share/java/
}
