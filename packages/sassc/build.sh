CLANDRO_PKG_HOMEPAGE=https://github.com/sass/sassc
CLANDRO_PKG_DESCRIPTION="libsass command line driver"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION=3.6.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sass/sassc/archive/refs/tags/${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=d9f8ae15894546fe973417ab85909fb70310de3a01a8a2d4c7a3182b03d5c6d7
CLANDRO_PKG_DEPENDS="libsass"

clandro_step_pre_configure() {
	autoreconf -fi
}
