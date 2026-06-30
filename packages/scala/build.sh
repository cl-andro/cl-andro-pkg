CLANDRO_PKG_HOMEPAGE=https://www.scala-lang.org
CLANDRO_PKG_DESCRIPTION="Scala 3 compiler and standard library."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.8.3"
CLANDRO_PKG_SRCURL=https://github.com/lampepfl/dotty/releases/download/$CLANDRO_PKG_VERSION/scala3-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ff62e827eb1ea17813d97e5fd5e0d2690110787173fe1e1e43d9dadcc3542fa7
CLANDRO_PKG_DEPENDS="openjdk-21, which"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	rm -f ./bin/*.bat
	rm -rf $CLANDRO_PREFIX/opt/scala
	mkdir -p $CLANDRO_PREFIX/opt/scala
	cp -r ./* $CLANDRO_PREFIX/opt/scala/
	ln -sfr $CLANDRO_PREFIX/opt/scala/libexec/scala-cli.jar $CLANDRO_PREFIX/opt/scala/bin/scala-cli.jar
	for i in $CLANDRO_PREFIX/opt/scala/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $CLANDRO_PREFIX/bin/$(basename $i)
	done
}
