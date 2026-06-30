# Contributor: @michalbednarski
CLANDRO_PKG_HOMEPAGE=https://github.com/cl-andro/ClandroAm
CLANDRO_PKG_DESCRIPTION="Android Oreo-compatible am command reimplementation"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
CLANDRO_PKG_VERSION=0.8.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/ClandroAm/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=7d4cfa2bfff93d5fc89fc89e537d2c072e08918276b140b7ed48ea45ebfbe8f3
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFLICTS="clandro-tools (<< 0.51)"
_GRADLE_VERSION=8.10.2

clandro_step_post_get_source() {
	sed -i'' -E -e "s|\@CLANDRO_PREFIX\@|${CLANDRO_PREFIX}|g" "$CLANDRO_PKG_SRCDIR/am-libexec-packaged"
	sed -i'' -E -e "s|\@CLANDRO_APP_PACKAGE\@|${CLANDRO_APP_PACKAGE}|g" "$CLANDRO_PKG_SRCDIR/app/src/main/java/com/clandro/clandroam/FakeContext.java"
	# Fix hardcoded .clandro paths and class name in the shell script
	sed -i'' -E \
		-e "s|~/\?\.clandro/clandro\.properties|~/.cl-andro/clandro.properties|g" \
		-e "s|com\.clandro\.clandroam\.Am|${CLANDRO_APP_PACKAGE}.clandroam.Am|g" \
		"$CLANDRO_PKG_SRCDIR/am-libexec-packaged"
}

clandro_step_make() {
	# Download and use a new enough gradle version to avoid the process hanging after running:
	clandro_download \
		https://services.gradle.org/distributions/gradle-$_GRADLE_VERSION-bin.zip \
		$CLANDRO_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip \
		31c55713e40233a8303827ceb42ca48a47267a0ad4bab9177123121e71524c26
	mkdir $CLANDRO_PKG_TMPDIR/gradle
	unzip -q $CLANDRO_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip -d $CLANDRO_PKG_TMPDIR/gradle

	# Avoid spawning the gradle daemon due to org.gradle.jvmargs
	# being set (https://github.com/gradle/gradle/issues/1434):
	sed -i'' -E '/^org\.gradle\.jvmargs=.*/d' gradle.properties

	export ANDROID_HOME
	export GRADLE_OPTS="-Dorg.gradle.daemon=false -Xmx1536m -Dorg.gradle.java.home=/usr/lib/jvm/java-1.17.0-openjdk-amd64"

	$CLANDRO_PKG_TMPDIR/gradle/gradle-$_GRADLE_VERSION/bin/gradle \
		:app:assembleRelease
}

clandro_step_make_install() {
	cp $CLANDRO_PKG_SRCDIR/am-libexec-packaged $CLANDRO_PREFIX/bin/am
	mkdir -p $CLANDRO_PREFIX/libexec/clandro-am
	cp $CLANDRO_PKG_SRCDIR/app/build/outputs/apk/release/app-release-unsigned.apk $CLANDRO_PREFIX/libexec/clandro-am/am.apk
}
