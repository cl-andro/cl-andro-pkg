CLANDRO_PKG_HOMEPAGE=https://github.com/scop/bash-completion
CLANDRO_PKG_DESCRIPTION="Programmable completion for the bash shell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2.17.0"
CLANDRO_PKG_REVISION="2"
CLANDRO_PKG_SRCURL=https://github.com/scop/bash-completion/releases/download/${CLANDRO_PKG_VERSION}/bash-completion-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=dd9d825e496435fb3beba3ae7bea9f77e821e894667d07431d1d4c8c570b9e58
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
# This package provides completions for many others, and there are a few conflicts.
# patchutils - interdiff
CLANDRO_PKG_RM_AFTER_INSTALL="
share/bash-completion/completions/interdiff
share/bash-completion/completions/makepkg
share/bash-completion/completions/tmux
"
