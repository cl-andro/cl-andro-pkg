CLANDRO_PKG_HOMEPAGE=https://github.com/skylot/jadx
CLANDRO_PKG_DESCRIPTION="Dex to Java decompiler"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE, NOTICE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.5"
CLANDRO_PKG_SRCURL=https://github.com/skylot/jadx/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8c1af4a9aebd5334367d5d60c8d56b02755b2027f9f8bc6633b5c3afdc273e1a
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	export JADX_VERSION="$CLANDRO_PKG_VERSION"
	./gradlew clean dist

	local exe
	for exe in jadx jadx-gui; do
		sed -i "s#CLASSPATH=\$APP_HOME/lib#CLASSPATH=$CLANDRO_PREFIX/share/java#g" \
			"$CLANDRO_PKG_SRCDIR/build/jadx/bin/$exe"
	done
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin build/jadx/bin/jadx
	install -Dm755 -t $CLANDRO_PREFIX/bin build/jadx/bin/jadx-gui

	rm -rf "$CLANDRO_PREFIX/share/java/jadx-$CLANDRO_PKG_VERSION-all.jar"
	mkdir -p $CLANDRO_PREFIX/share/java/
	install -Dm700 -t $CLANDRO_PREFIX/share/java build/jadx/lib/*
}
