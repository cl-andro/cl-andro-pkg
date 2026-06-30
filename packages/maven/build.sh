CLANDRO_PKG_HOMEPAGE=https://maven.apache.org/
CLANDRO_PKG_DESCRIPTION="A Java software project management and comprehension tool"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.9.15"
CLANDRO_PKG_SRCURL=https://dlcdn.apache.org/maven/maven-3/${CLANDRO_PKG_VERSION}/binaries/apache-maven-${CLANDRO_PKG_VERSION}-bin.tar.gz
CLANDRO_PKG_SHA256=36182f85e91128cd5c4608462ac92194e7a30638f65034de66f4e1b00600a6fc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libjansi (>= 2.4.0-1), openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	# Remove starter scripts for Windows
	rm -f bin/*.cmd
	# Remove DLL for Windows
	rm -rf lib/jansi-native/Windows
	ln -sf $CLANDRO_PREFIX/lib/jansi/libjansi.so lib/jansi-native/
	rm -rf $CLANDRO_PREFIX/opt/maven
	mkdir -p $CLANDRO_PREFIX/opt
	cp -a $CLANDRO_PKG_SRCDIR $CLANDRO_PREFIX/opt/maven/
	# Symlink only starter scripts for Linux
	for i in mvn mvnDebug mvnyjp; do
		ln -sfr $CLANDRO_PREFIX/opt/maven/bin/$i $CLANDRO_PREFIX/bin/$i
	done
}
