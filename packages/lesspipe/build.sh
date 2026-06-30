CLANDRO_PKG_HOMEPAGE=https://lesspipe.org/
CLANDRO_PKG_DESCRIPTION="An input filter for the pager less"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2.25"
CLANDRO_PKG_SRCURL=https://github.com/wofr06/lesspipe/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fb9d026bdeb81ccdb054c31e292112805ec48b7463978a4cf2af556c7a63487a
CLANDRO_PKG_DEPENDS="file, less"
CLANDRO_PKG_BUILD_DEPENDS="bash-completion"
CLANDRO_PKG_SUGGESTS="7zip | p7zip, imagemagick, perl, unrar, unzip"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	./configure \
		--prefix="$CLANDRO_PREFIX" \
		--bash-completion-dir="${CLANDRO_PREFIX}/share/bash-completion/completions" \
		--zsh-completion-dir="${CLANDRO_PREFIX}/share/zsh/site-functions"
}

clandro_step_post_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/etc/profile.d
	echo "export LESSOPEN='|$CLANDRO_PREFIX/bin/lesspipe.sh %s'" \
		> "$CLANDRO_PREFIX"/etc/profile.d/lesspipe.sh
	ln -sf "$CLANDRO_PREFIX/bin/lesspipe.sh" "$CLANDRO_PREFIX/bin/lesspipe"
}
