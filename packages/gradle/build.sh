CLANDRO_PKG_HOMEPAGE=https://gradle.org/
CLANDRO_PKG_DESCRIPTION="Powerful build system for the JVM"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:9.5.0"
CLANDRO_PKG_SRCURL=https://services.gradle.org/distributions/gradle-${CLANDRO_PKG_VERSION:2}-bin.zip
CLANDRO_PKG_SHA256=553c78f50dafcd54d65b9a444649057857469edf836431389695608536d6b746
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $CLANDRO_PREFIX/opt/gradle
	mkdir -p $CLANDRO_PREFIX/opt/gradle
	cp -r ./* $CLANDRO_PREFIX/opt/gradle/
	for i in $CLANDRO_PREFIX/opt/gradle/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $CLANDRO_PREFIX/bin/$(basename $i)
	done
}
