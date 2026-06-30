CLANDRO_PKG_HOMEPAGE=https://ant.apache.org/
CLANDRO_PKG_DESCRIPTION="Java based build tool like make"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.17"
CLANDRO_PKG_SRCURL=https://dlcdn.apache.org//ant/binaries/apache-ant-${CLANDRO_PKG_VERSION}-bin.tar.bz2
CLANDRO_PKG_SHA256=5210fc9d77e96bf5f4639287f29826da85e54a542e0a409463b1642bc3caaee7
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	mv ./bin/ant .
	rm -f ./bin/*
	mv ./ant ./bin/
	rm -rf manual
	rm -rf $CLANDRO_PREFIX/opt/ant
	mkdir -p $CLANDRO_PREFIX/opt/ant
	cp -r ./* $CLANDRO_PREFIX/opt/ant
	ln -sfr $CLANDRO_PREFIX/opt/ant/bin/ant $CLANDRO_PREFIX/bin/ant
}
