CLANDRO_PKG_HOMEPAGE=https://rogerbinns.github.io/apsw/
CLANDRO_PKG_DESCRIPTION="Another Python SQLite Wrapper"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.53.1.0"
CLANDRO_PKG_SRCURL=https://github.com/rogerbinns/apsw/releases/download/${CLANDRO_PKG_VERSION}/apsw-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b1bcb3235c20f50c4293e104a657b0dc3ce049f4d4443fe4acb1074677cf2912
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libsqlite, python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/setup.cfg ./
}

clandro_step_make() {
	:
}
