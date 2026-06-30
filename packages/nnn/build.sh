CLANDRO_PKG_HOMEPAGE=https://github.com/jarun/nnn
CLANDRO_PKG_DESCRIPTION="Free, fast, friendly file browser"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.2"
CLANDRO_PKG_SRCURL=https://github.com/jarun/nnn/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f166eda5093ac8dcf8cbbc6224123a32c53cf37b82c5c1cb48e2e23352754030
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="file, findutils, readline, wget, libandroid-support, lzip"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_make_install() {
	install -Dm600 misc/auto-completion/bash/nnn-completion.bash \
		$CLANDRO_PREFIX/share/bash-completion/completions/nnn
	install -Dm600 misc/auto-completion/fish/nnn.fish \
		$CLANDRO_PREFIX/share/fish/vendor_completions.d/nnn.fish
	install -Dm600 misc/auto-completion/zsh/_nnn \
		$CLANDRO_PREFIX/share/zsh/site-functions/_nnn
}
