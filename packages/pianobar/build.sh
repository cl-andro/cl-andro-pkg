CLANDRO_PKG_HOMEPAGE=https://6xq.net/pianobar/
CLANDRO_PKG_DESCRIPTION="pianobar is a free/open-source, console-based client for the personalized online radio Pandora."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2024.12.21"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/PromyLOPh/pianobar/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e988dff4a4b7cc6a19e944b7516f697d7e6c41d6dc0ff25a708bcb6b92d72a89
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libao, ffmpeg, libgcrypt, libcurl, json-c"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_make_install(){
	#install useful script
	install -Dm755 "$CLANDRO_PKG_SRCDIR"/contrib/headless_pianobar "$CLANDRO_PREFIX"/bin/pianoctl
}
