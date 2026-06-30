CLANDRO_PKG_HOMEPAGE=https://www.greenwoodsoftware.com/less/
CLANDRO_PKG_DESCRIPTION="Terminal pager program used to view the contents of a text file one screen at a time"
# less has both the GPLv3 and its own "less license" which is a variation of a BSD 2-Clause license
CLANDRO_PKG_LICENSE="GPL-3.0, custom"
CLANDRO_PKG_LICENSE_FILE='COPYING, LICENSE'
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="692"
CLANDRO_PKG_SRCURL="https://github.com/gwsw/less/archive/refs/tags/v${CLANDRO_PKG_VERSION}-rel.tar.gz"
CLANDRO_PKG_SHA256=41d74ef73e548fbd2c3df3a28195a16cc1b995da720d853d7e3b2cbec473236f
CLANDRO_PKG_DEPENDS="ncurses, pcre2"
CLANDRO_PKG_REPLACES="lazyread"
CLANDRO_PKG_ESSENTIAL=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-regex=pcre2
--with-editor=editor
"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/lesskey share/man"
CLANDRO_PKG_AUTO_UPDATE=true
# Official `less` release tags are marked with a `-rel` suffix
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d{3}(?=-rel)'

clandro_pkg_auto_update() {
	local latest_tags
	latest_tags="$(
		CLANDRO_PKG_SRCURL="https://github.com/gwsw/less" \
		clandro_github_api_get_tag
	)"

	clandro_pkg_upgrade_version "${latest_tags}"
}

clandro_step_pre_configure() {
	autoreconf -fi
	# Generate help.c and funcs.h (not included in GitHub release tarballs)
	cd "${CLANDRO_PKG_SRCDIR}"
	if [ ! -f help.c ]; then
		./mkhelp.sh < less.hlp > help.c
	fi
	if [ ! -f funcs.h ]; then
		local src_list
		src_list="main.c screen.c brac.c ch.c charset.c cmdbuf.c command.c cvt.c decode.c edit.c evar.c filename.c forwback.c help.c ifile.c input.c jump.c line.c linenum.c lsystem.c mark.c optfunc.c option.c opttbl.c os.c output.c pattern.c position.c prompt.c search.c signal.c tags.c ttyin.c version.c xbuf.c"
		grep -h '^public [^;]*$' $src_list | sed 's/$/;/' > funcs.h
	fi
	# Remove .nro man page dependencies from install target (not in GitHub tarballs)
	sed -i 's/^install: all ${srcdir}\/less\.nro ${srcdir}\/lesskey\.nro ${srcdir}\/lessecho\.nro installdirs/install: all installdirs/' Makefile.in
	# Create stub .nro files for install (missing from GitHub tarballs)
	touch less.nro lesskey.nro lessecho.nro
}
