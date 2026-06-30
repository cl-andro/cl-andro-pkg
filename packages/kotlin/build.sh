CLANDRO_PKG_HOMEPAGE=https://kotlinlang.org/
CLANDRO_PKG_DESCRIPTION="The Kotlin Programming Language"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.21"
CLANDRO_PKG_SRCURL=https://github.com/JetBrains/kotlin/releases/download/v${CLANDRO_PKG_VERSION}/kotlin-compiler-${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=a8cfc1d62cd4d0de4d04f42575e40135bd620588c17d568a20eb9c7c259af14f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $CLANDRO_PREFIX/opt/kotlin
	mkdir -p $CLANDRO_PREFIX/opt/kotlin
	cp -r ./* $CLANDRO_PREFIX/opt/kotlin/
	for i in $CLANDRO_PREFIX/opt/kotlin/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $CLANDRO_PREFIX/bin/$(basename $i)
	done
}
