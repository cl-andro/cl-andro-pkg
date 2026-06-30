CLANDRO_PKG_HOMEPAGE=https://git-scm.com/
CLANDRO_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2.54.0"
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/pub/software/scm/git/git-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f689162364c10de79ef89aa8dbf48731eb057e34edbbd20aca510ce0154681a3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, libexpat, libiconv, less, openssl, pcre2, zlib"
CLANDRO_PKG_RECOMMENDS="openssh"
CLANDRO_PKG_SUGGESTS="perl"

## This requires a working $CLANDRO_PREFIX/bin/sh on the host building:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_iconv_omits_bom=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--with-expat
--with-shell=$CLANDRO_PREFIX/bin/sh
--with-tcltk=$CLANDRO_PREFIX/bin/wish
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
CLANDRO_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_INSTALL_HARDLINKS=1
CSPRNG_METHOD=openssl
PERL_PATH=$CLANDRO_PREFIX/bin/perl
USE_LIBPCRE2=1
DEFAULT_PAGER=pager
DEFAULT_EDITOR=editor
"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == 'true' ]]; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Setup perl so that the build process can execute it:
	rm -f "$CLANDRO_PREFIX/bin/perl"
	ln -s "$(command -v perl)" "$CLANDRO_PREFIX/bin/perl"

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -rf "$CLANDRO_PREFIX/share/git-perl"

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$CLANDRO_PKG_SRCDIR $CPPFLAGS"
}

clandro_step_post_make_install() {
	# shellcheck disable=SC2086 # We need word splitting on the extra args
	{
	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" install-man

	make -j "$CLANDRO_PKG_MAKE_PROCESSES" -C contrib/subtree $CLANDRO_PKG_EXTRA_MAKE_ARGS
	make -C contrib/subtree $CLANDRO_PKG_EXTRA_MAKE_ARGS "${CLANDRO_PKG_MAKE_INSTALL_TARGET}"
	make -j "$CLANDRO_PKG_MAKE_PROCESSES" -C contrib/subtree install-man
	}
	mkdir -p "$CLANDRO_PREFIX/etc/bash_completion.d/"
	cp "$CLANDRO_PKG_SRCDIR/contrib/completion/git-completion.bash" \
		"$CLANDRO_PKG_SRCDIR/contrib/completion/git-prompt.sh" \
		"$CLANDRO_PREFIX/etc/bash_completion.d/"

	# Remove the build machine perl setup in clandro_step_pre_configure to avoid it being packaged:
	rm "$CLANDRO_PREFIX/bin/perl"

	# Remove clutter:
	rm -rf "$CLANDRO_PREFIX/lib"/*-linux*/perl

	# shellcheck disable=SC2164
	( # Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
		cd "$CLANDRO_PREFIX/bin"
		ln -sf ../libexec/git-core/git git
		ln -sf ../libexec/git-core/git-upload-pack git-upload-pack
		cd "$CLANDRO_PREFIX/libexec/git-core"
		ln -sf git-gui git-citool
	)
}

clandro_step_post_massage() {
	if [[ ! -f libexec/git-core/git-remote-https ]]; then
		clandro_error_exit "Git built without https support"
	fi
}
