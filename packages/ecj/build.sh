CLANDRO_PKG_HOMEPAGE=https://www.eclipse.org/jdt/core/
CLANDRO_PKG_DESCRIPTION="Eclipse Compiler for Java"
CLANDRO_PKG_LICENSE="EPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Version 4.12 is the last known to work on Android 7-8.
_VERSION=4.12
_DATE=201906051800
CLANDRO_PKG_VERSION=1:${_VERSION}
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://archive.eclipse.org/eclipse/downloads/drops${_VERSION:0:1}/R-${_VERSION}-${_DATE}/ecj-${_VERSION}.jar
CLANDRO_PKG_SHA256=69dad18a1fcacd342a7d44c5abf74f50e7529975553a24c64bce0b29b86af497
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_CONFLICTS="ecj4.6"

RAW_JAR=$CLANDRO_PKG_CACHEDIR/ecj-${_VERSION}.jar

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_get_source() {
	mkdir -p $CLANDRO_PKG_SRCDIR
	clandro_download $CLANDRO_PKG_SRCURL \
		$RAW_JAR \
		$CLANDRO_PKG_SHA256
}

clandro_step_make() {
	mkdir -p $CLANDRO_PREFIX/share/{dex,java}
	$CLANDRO_D8 \
		--classpath $ANDROID_HOME/platforms/android-$CLANDRO_PKG_API_LEVEL/android.jar \
		--release \
		--min-api $CLANDRO_PKG_API_LEVEL \
		--output $CLANDRO_PKG_TMPDIR \
		$RAW_JAR

	# Package classes.dex into jar:
	cd $CLANDRO_PKG_TMPDIR
	jar cf ecj.jar classes.dex
	# Add needed properties file to jar file:
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/readableNames.props
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/readableNames.props
	for i in $(seq 1 24); do
		jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
		jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
	done
	# Move into place:
	mv ecj.jar $CLANDRO_PREFIX/share/dex/ecj.jar

	rm -rf android-jar
	mkdir android-jar
	cd android-jar

	# We need the android classes for JDT to compile against.
	cp $ANDROID_HOME/platforms/android-28/android.jar .
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android.jar .

	cp $CLANDRO_PKG_TMPDIR/android-jar/android.jar $CLANDRO_PREFIX/share/java/android.jar

	# Bundle in an android.jar from an older API also, for those who want to
	# build apps that run on older Android versions.
	rm -Rf ./*
	cp $ANDROID_HOME/platforms/android-$CLANDRO_PKG_API_LEVEL/android.jar android.jar
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android-$CLANDRO_PKG_API_LEVEL.jar .
	cp $CLANDRO_PKG_TMPDIR/android-jar/android-$CLANDRO_PKG_API_LEVEL.jar $CLANDRO_PREFIX/share/java/

	rm -Rf $CLANDRO_PREFIX/bin/javac
	install $CLANDRO_PKG_BUILDER_DIR/ecj $CLANDRO_PREFIX/bin/ecj
	perl -p -i -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" $CLANDRO_PREFIX/bin/ecj
	install $CLANDRO_PKG_BUILDER_DIR/ecj-$CLANDRO_PKG_API_LEVEL $CLANDRO_PREFIX/bin/ecj-$CLANDRO_PKG_API_LEVEL
	perl -p -i -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" $CLANDRO_PREFIX/bin/ecj-$CLANDRO_PKG_API_LEVEL
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${CLANDRO_PREFIX}/bin/bash
	chmod -w $CLANDRO_PREFIX/share/dex/ecj.jar
	rm -f $CLANDRO_PREFIX/share/dex/oat/*/ecj.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}
