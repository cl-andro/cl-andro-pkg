CLANDRO_PKG_HOMEPAGE=https://github.com/ggerganov/imtui
CLANDRO_PKG_DESCRIPTION="An immediate mode text-based user interface library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE, third-party/imgui/imgui/LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.5
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/ggerganov/imtui
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
"

clandro_step_post_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin bin/hnterm
}
