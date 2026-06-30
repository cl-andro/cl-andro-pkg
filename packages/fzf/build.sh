CLANDRO_PKG_HOMEPAGE=https://junegunn.github.io/fzf/
CLANDRO_PKG_DESCRIPTION="Command-line fuzzy finder"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.72.0"
CLANDRO_PKG_SRCURL=https://github.com/junegunn/fzf/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ca5ce083cec5187503ceb96d837c20d8efde85f03e62bba3a8890f8da526f2fc
CLANDRO_PKG_AUTO_UPDATE=true

# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
CLANDRO_PKG_DEPENDS="bash, findutils, ncurses-utils"
CLANDRO_PKG_SUGGESTS="tmux"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/junegunn
	mv $CLANDRO_PKG_SRCDIR $GOPATH/src/github.com/junegunn/fzf
	CLANDRO_PKG_SRCDIR=$GOPATH/src/github.com/junegunn/fzf

	cd $GOPATH/src/github.com/junegunn/fzf
	go get -d -v github.com/junegunn/fzf
	go build
}

clandro_step_make_install() {
	cd $GOPATH/src/github.com/junegunn/fzf

	install -Dm700 fzf $CLANDRO_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	install -Dm700 $CLANDRO_PKG_SRCDIR/bin/fzf-tmux $CLANDRO_PREFIX/bin/fzf-tmux

	# Install the fzf.1 man page:
	mkdir -p $CLANDRO_PREFIX/share/man/man1/
	cp $CLANDRO_PKG_SRCDIR/man/man1/fzf.1 $CLANDRO_PREFIX/share/man/man1/

	# Install the rest of the shell scripts:
	mkdir -p $CLANDRO_PREFIX/share/fzf
	cp $CLANDRO_PKG_SRCDIR/shell/* $CLANDRO_PREFIX/share/fzf/

	# Symlink shell completions.
	mkdir -p $CLANDRO_PREFIX/share/bash-completion/completions/
	ln -sfr $CLANDRO_PREFIX/share/fzf/completion.bash $CLANDRO_PREFIX/share/bash-completion/completions/fzf
	mkdir -p $CLANDRO_PREFIX/share/zsh/site-functions
	ln -sfr $CLANDRO_PREFIX/share/fzf/completion.zsh $CLANDRO_PREFIX/share/zsh/site-functions/_fzf

	# Fish keybindings.
	mkdir -p $CLANDRO_PREFIX/share/fish/vendor_functions.d
	ln -sfr $CLANDRO_PREFIX/share/fzf/key-bindings.fish $CLANDRO_PREFIX/share/fish/vendor_functions.d/fzf_key_bindings.fish

	# Install the nvim plugin:
	mkdir -p $CLANDRO_PREFIX/share/nvim/runtime/plugin
	cp $CLANDRO_PKG_SRCDIR/plugin/fzf.vim $CLANDRO_PREFIX/share/nvim/runtime/plugin/
}
