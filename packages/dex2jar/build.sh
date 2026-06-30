CLANDRO_PKG_HOMEPAGE=https://github.com/pxb1988/dex2jar
CLANDRO_PKG_DESCRIPTION="Tools to work with android .dex and java .class files"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/pxb1988/dex2jar/releases/download/v${CLANDRO_PKG_VERSION}/dex-tools-v${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=ee7c45eb3c1d2474a6145d8d447e651a736a22d9664b6d3d3be5a5a817dda23a
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	rm -rf ./bin/*.bat
	rm -rf ./*.bat
	mkdir -p $CLANDRO_PREFIX/opt/dex2jar
	cp -r ./* $CLANDRO_PREFIX/opt/dex2jar
	ln -sfr $CLANDRO_PREFIX/opt/dex2jar/bin/dex-tools $CLANDRO_PREFIX/bin/d2j-run
	cd $CLANDRO_PREFIX/opt/dex2jar/
	for i in *.sh; do
		ln -sfr $CLANDRO_PREFIX/opt/dex2jar/$i $CLANDRO_PREFIX/bin/${i%%.sh}
	done
}
