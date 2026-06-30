CLANDRO_PKG_HOMEPAGE=https://packages.debian.org/sid/csh
CLANDRO_PKG_DESCRIPTION="C Shell with process control from 3BSD"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=20110502
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/c/csh/csh_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=8bcba4fe796df1b9992e2d94e07ce6180abb24b55488384f9954aa61ecd8d68b
CLANDRO_PKG_DEPENDS="libandroid-glob, libbsd"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/LICENSE ./
}

clandro_step_pre_configure() {
	CFLAGS="${CFLAGS/-Oz/-Os}"
	LDFLAGS+=" -Wl,-z,muldefs"
}

clandro_step_post_configure() {
	make const.h
}

clandro_step_post_make_install() {
	install -Dm600 -T ./csh.1 ${CLANDRO_PREFIX}/share/man/man1/csh.1
}
