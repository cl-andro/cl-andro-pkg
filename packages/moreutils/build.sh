CLANDRO_PKG_HOMEPAGE=https://joeyh.name/code/moreutils/
CLANDRO_PKG_DESCRIPTION="A growing collection of the unix tools that nobody thought to write thirty years ago"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.70"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_GIT_BRANCH=master
CLANDRO_PKG_SRCURL=git+https://git.joeyh.name/git/moreutils.git
CLANDRO_PKG_SHA256=2170c46219ce8d6f17702321534769dfbfece52148a78cd12ea73b5d3a72ff7c
CLANDRO_PKG_DEPENDS="perl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

# chronic requires set of external perl modules.
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/chronic
share/man/man1/chronic.1
share/man/man1/parallel.1
"

clandro_step_get_source() {
	# The source repo for this package only provides dumb http transport.
	# So this is mostly a duplicate of `clandro_git_clone_src`
	# without `--depth 1` to avoid:
	#
	# fatal: dumb http transport does not support shallow capabilities
	local TMP_CHECKOUT="$CLANDRO_PKG_CACHEDIR/tmp-checkout"
	local TMP_CHECKOUT_VERSION="$CLANDRO_PKG_CACHEDIR/tmp-checkout-version"

	if [[ ! -f $TMP_CHECKOUT_VERSION || "$(< "$TMP_CHECKOUT_VERSION")" != "$CLANDRO_PKG_VERSION" ]]; then
		rm -rf "$TMP_CHECKOUT"
		git clone \
			--branch "$CLANDRO_PKG_GIT_BRANCH" \
			"${CLANDRO_PKG_SRCURL:4}" \
			"$TMP_CHECKOUT"
		echo "$CLANDRO_PKG_VERSION" > "$TMP_CHECKOUT_VERSION"
	fi
	rm -rf "$CLANDRO_PKG_SRCDIR"
	cp -Rf "$TMP_CHECKOUT" "$CLANDRO_PKG_SRCDIR"
}


clandro_step_post_get_source() {
	git checkout "$CLANDRO_PKG_VERSION"
}
