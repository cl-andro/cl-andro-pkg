CLANDRO_PKG_HOMEPAGE=https://projects.unbit.it/uwsgi
CLANDRO_PKG_DESCRIPTION="uWSGI application server container"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.31"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/unbit/uwsgi/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=d5fb7b058a6e037cad1f0fb8841de56d673d80a3af036bba830143b60c67c3dc
CLANDRO_PKG_DEPENDS="libandroid-glob, libandroid-sysv-semaphore, libandroid-utimes, libcap, libcrypt, libjansson, libuuid, libxml2, openssl, pcre2, python"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	export UWSGI_PYTHON_NOLIB=true
	export UWSGI_INCLUDES="$CLANDRO_PREFIX/include"
	export APPEND_CFLAGS="$CPPFLAGS
		-I$CLANDRO_PREFIX/include/python${CLANDRO_PYTHON_VERSION}
		-DOBSOLETE_LINUX_KERNEL
		"
	LDFLAGS+="
		-lpython${CLANDRO_PYTHON_VERSION}
		-landroid-glob
		-landroid-sysv-semaphore
		-landroid-utimes
		"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin "$CLANDRO_PKG_BUILDDIR/uwsgi"
}
