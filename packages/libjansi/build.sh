CLANDRO_PKG_HOMEPAGE=https://fusesource.github.io/jansi/
CLANDRO_PKG_DESCRIPTION="A small java library that allows you to use ANSI escape codes to format your console output"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.3"
CLANDRO_PKG_SRCURL=git+https://github.com/fusesource/jansi
CLANDRO_PKG_GIT_BRANCH=jansi-${CLANDRO_PKG_VERSION}
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	clandro_download https://raw.githubusercontent.com/openjdk/jdk/jdk-11%2B28/src/java.base/unix/native/include/jni_md.h \
		${CLANDRO_PKG_CACHEDIR}/jni_md.h 48888b52ef525a8c92985b501162b2e4ca7bb2a742456e4c053c1417e8ccfff2
}

clandro_step_make() {
	local s=$CLANDRO_PKG_SRCDIR/src/main/native/jansi
	${CC} -o ${CLANDRO_PKG_SRCDIR}/libjansi.so \
		${s}.c ${s}_isatty.c ${s}_structs.c ${s}_ttyname.c \
		${CFLAGS} -fPIC -I${CLANDRO_PKG_CACHEDIR} ${LDFLAGS} -shared
}

clandro_step_make_install() {
	install -Dm700 -t ${CLANDRO_PREFIX}/lib/jansi ${CLANDRO_PKG_SRCDIR}/libjansi.so
}
