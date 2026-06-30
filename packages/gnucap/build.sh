CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gnucap/gnucap.html
CLANDRO_PKG_DESCRIPTION="The Gnu Circuit Analysis Package"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_VERSION=20210107
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://gitlab.com/gnucap/gnucap/-/archive/${CLANDRO_PKG_VERSION}/gnucap-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d2c24a66c7e60b379727c9e9487ed1b4a3532646b3f4cc03c6a4305749e3348b
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++, readline"
CLANDRO_PKG_BREAKS="gnucap-dev"
CLANDRO_PKG_REPLACES="gnucap-dev"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build () {
	cp -r $CLANDRO_PKG_SRCDIR/* .
	./configure
	(cd lib && make)
	(cd modelgen && make)
}

clandro_step_pre_configure () {
	sed -i "s%@CLANDRO_PKG_HOSTBUILD_DIR@%$CLANDRO_PKG_HOSTBUILD_DIR%g" $CLANDRO_PKG_SRCDIR/apps/Make1
}

clandro_step_configure () {
	$CLANDRO_PKG_SRCDIR/configure --prefix=$CLANDRO_PREFIX
}
