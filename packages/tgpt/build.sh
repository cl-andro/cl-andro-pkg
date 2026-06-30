CLANDRO_PKG_HOMEPAGE=https://github.com/aandrew-me/tgpt
CLANDRO_PKG_DESCRIPTION="AI Chatbots in terminal without needing API keys"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.1"
CLANDRO_PKG_SRCURL=https://github.com/aandrew-me/tgpt/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e7a02a0d40b7a6761e5e4550210db04baca7c6113430c3efc9643b9ebca01e32
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	go build -trimpath -ldflags="-s -w"
}

clandro_step_make_install() {
	install -Dm700 tgpt "$CLANDRO_PREFIX"/bin/tgpt
}
