CLANDRO_PKG_HOMEPAGE="https://github.com/tj/git-extras"
CLANDRO_PKG_DESCRIPTION="Little git extras."
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.4.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/tj/git-extras/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=aaab3bab18709ec6825a875961e18a00e0c7d8214c39d6e3a63aeb99fa11c56e
CLANDRO_PKG_DEPENDS="bash, git, util-linux, gawk, findutils, ncurses-utils"
CLANDRO_PKG_RECOMMENDS="curl, procps, rsync"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Directory where `make install` will place bash completion script
	export COMPL_DIR="$CLANDRO_PREFIX/share/bash-completion/completions"
}

clandro_step_make() {
	# `make` and `make install` does the same thing
	# So, this is an empty function
	:
}

clandro_step_post_make_install() {
	install -Dm644 etc/bash_completion.sh "${CLANDRO_PREFIX}/share/bash-completion/completions/git-extras"
	install -Dm644 etc/git-extras-completion.zsh "${CLANDRO_PREFIX}/share/zsh/site-functions/_git-extras"
	install -Dm644 etc/git-extras.fish "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/git-extras.fish
}
