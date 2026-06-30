CLANDRO_PKG_HOMEPAGE=https://www.vim.org
CLANDRO_PKG_DESCRIPTION="Vi IMproved - enhanced vi editor"
CLANDRO_PKG_LICENSE="VIM License"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_BUILD_DEPENDS="luajit, perl, python, ruby, tcl"
CLANDRO_PKG_DEPENDS="libiconv, libsodium, ncurses"
CLANDRO_PKG_SUGGESTS="luajit, perl, python, ruby, tcl"
CLANDRO_PKG_RECOMMENDS="diffutils, xxd"
CLANDRO_PKG_CONFLICTS="vim-gtk"
CLANDRO_PKG_BREAKS="vim-python, vim-runtime"
CLANDRO_PKG_REPLACES="vim-python, vim-runtime"
CLANDRO_PKG_PROVIDES="vim-python"
CLANDRO_PKG_VERSION="9.2.0450"
CLANDRO_PKG_SRCURL="https://github.com/vim/vim/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6811815aaa2c40d72837f62dce17d1cbc69def741863ae485d52396695453ad6
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_CONFFILES="share/vim/vimrc"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgetent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
ac_cv_small_wchar_t=no
--with-features=huge
--enable-netbeans=no
--with-tlib=ncursesw
--enable-multibyte
--with-compiledby=Termux
--enable-fail-if-missing=yes
--enable-python3interp=dynamic
--with-python3-config-dir=$CLANDRO_PYTHON_HOME/config-${CLANDRO_PYTHON_VERSION}-${CLANDRO_HOST_PLATFORM}/
vi_cv_path_python3_pfx=$CLANDRO_PREFIX
vi_cv_path_python3_include=${CLANDRO_PREFIX}/include/python${CLANDRO_PYTHON_VERSION}
vi_cv_path_python3_platinclude=${CLANDRO_PREFIX}/include/python${CLANDRO_PYTHON_VERSION}
vi_cv_var_python3_abiflags=
vi_cv_var_python3_version=${CLANDRO_PYTHON_VERSION}
--enable-luainterp=dynamic
--with-lua-prefix=$CLANDRO_PREFIX
--with-luajit
--enable-perlinterp=dynamic
--with-xsubpp=$CLANDRO_PREFIX/bin/xsubpp
--enable-rubyinterp=dynamic
--enable-tclinterp=dynamic
--enable-gui=no
--without-x
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag" # Vim doesn't use release tags

clandro_pkg_auto_update() {
	# This auto_update function is shared by `vim` and `vim-gtk`
	# If you make changes to one of them,
	# remember to apply that change to the other as well.
	local latest_tag current_patch latest_patch
	latest_tag="$(clandro_github_api_get_tag)"
	# Specify Base 10 with the `10#` prefix.
	# This is necessary to suppress automatic interpretation
	# of the value as octal when there is a leading 0.
	latest_patch="10#${latest_tag##*.}"
	current_patch="10#${CLANDRO_PKG_VERSION##*.}"

	# Vim releases nearly every commit as a new tag.
	# To avoid auto update spam, we only update Vim every 50th patch.
	# To do that, floor each version to the last 50th.
	(( current_patch -= current_patch % 50 ))
	((  latest_patch -=  latest_patch % 50 ))

	if (( current_patch == latest_patch )); then
		echo "INFO: Skipping ${latest_tag#v}, no new 50th patch since $CLANDRO_PKG_VERSION."
		return
	fi

	# Pad the patch component of the version back to 4 digits in accordance with Vim's tag naming.
	clandro_pkg_upgrade_version "$(printf '%s.%04d' "${latest_tag%.*}" "${latest_patch}")"
}

clandro_step_pre_configure() {
	make distclean

	# Remove eventually existing symlinks from previous builds so that they get re-created.
	local -a VIM_BINARIES=('eview' 'evim' 'ex' 'rview' 'rvim' 'view' 'vimdiff')
	for sym in "${VIM_BINARIES[@]}"; do
		rm -f "${CLANDRO_PREFIX}/bin/${sym}"
		rm -f "$CLANDRO_PREFIX/share/man/man1/${sym}.1"*
	done

	# Vim doesn't support cross-compilation for Perl, Ruby and Tcl
	# out of the box, so we need to patch the configure script to make it work.
	local perl_version ruby_major_version tcl_major_version
	perl_version="$(. "$CLANDRO_SCRIPTDIR/packages/perl/build.sh"; echo "${CLANDRO_PKG_VERSION[0]}")"
	ruby_major_version="$(. "$CLANDRO_SCRIPTDIR/packages/ruby/build.sh"; echo "${CLANDRO_PKG_VERSION%\.*}")"
	tcl_major_version="$(. "$CLANDRO_SCRIPTDIR/packages/tcl/build.sh"; echo "${CLANDRO_PKG_VERSION%\.*}")"

	patch="$CLANDRO_PKG_BUILDER_DIR/configure-perl-ruby-tcl-cross-compiling.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && sed \
		-e "s%\@PERL_VERSION\@%${perl_version}%g" \
		-e "s%\@RUBY_MAJOR_VERSION\@%${ruby_major_version}%g" \
		-e "s%\@TCL_MAJOR_VERSION\@%${tcl_major_version}%g" \
		-e "s%\@PERL_PLATFORM\@%${CLANDRO_ARCH}-android%g" \
		-e "s%\@RUBY_PLATFORM\@%${CLANDRO_HOST_PLATFORM}%g" \
		-e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		"$patch" | patch --silent -p1
}

# shellcheck disable=SC2031
clandro_step_post_make_install() {
	sed -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" "$CLANDRO_PKG_BUILDER_DIR/vimrc" \
		> "$CLANDRO_PREFIX/share/vim/vimrc"

	local _VIM_VERSION="${CLANDRO_PKG_VERSION%.*}"
	_VIM_VERSION="${_VIM_VERSION/.}"

	export CLANDRO_PKG_RM_AFTER_INSTALL="
	share/vim/vim${_VIM_VERSION}/spell/en.ascii*
	share/vim/vim${_VIM_VERSION}/print
	share/vim/vim${_VIM_VERSION}/tools
	"

	### Remove most tutor files:
	# Make a directory to temporarily hold the ones we want to keep
	mkdir -p "$CLANDRO_PKG_TMPDIR/vim-tutor"
	# Copy what we want to keep into $CLANDRO_PKG_TMPDIR/vim-tutor
	cp -r   "$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor/en/" \
			"$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor/tutor.vim" \
			"$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor/tutor.tutor"{,.json} \
			"$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor/tutor"{1,2} \
			"$CLANDRO_PKG_TMPDIR/vim-tutor"
	# Remove all the tutor files
	rm -rf "$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor"/*
	# Copy back what we saved earlier
	cp -r "$CLANDRO_PKG_TMPDIR"/vim-tutor/* "$CLANDRO_PREFIX/share/vim/vim${_VIM_VERSION}/tutor/"
	mkdir -p "$CLANDRO_PREFIX/libexec/vim"
	mv "${CLANDRO_PREFIX}"/bin/{ex,view,vim{,diff,tutor}} "${CLANDRO_PREFIX}"/libexec/vim
}
