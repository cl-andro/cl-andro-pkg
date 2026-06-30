CLANDRO_PKG_HOMEPAGE=https://elixir-lang.org/
CLANDRO_PKG_DESCRIPTION="Elixir is a dynamic, functional language designed for building scalable and maintainable applications"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.19.5"
_ERLANG_MAJOR_VERSION=$(. "$CLANDRO_SCRIPTDIR"/packages/erlang/build.sh; echo "${CLANDRO_PKG_VERSION%%.*}")
CLANDRO_PKG_SRCURL=https://github.com/elixir-lang/elixir/releases/download/v${CLANDRO_PKG_VERSION}/elixir-otp-${_ERLANG_MAJOR_VERSION}.zip
CLANDRO_PKG_SHA256=ca481510feb6dabc875bba43e44b25c7abafa53bd7a103639851b7aeace8a022
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dash, erlang"
CLANDRO_PKG_SUGGESTS="clang, make"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_get_source() {
	clandro_download "$CLANDRO_PKG_SRCURL" "$CLANDRO_PKG_CACHEDIR"/prebuilt.zip \
		"$CLANDRO_PKG_SHA256"
	# Create src directory to avoid build-package.sh errors.
	mkdir -p "$CLANDRO_PKG_SRCDIR"
}

clandro_step_make_install() {
	# Unpack directly to $PREFIX/opt/elixir.
	mkdir -p "$CLANDRO_PREFIX"/opt
	rm -rf "$CLANDRO_PREFIX"/opt/elixir
	unzip -d "$CLANDRO_PREFIX"/opt/elixir "$CLANDRO_PKG_CACHEDIR"/prebuilt.zip

	# Remove unneeded files.
	(cd "$CLANDRO_PREFIX"/opt/elixir/man; rm -f common elixir.1.in iex.1.in)

	# Put manpages to standard location.
	for page in elixir.1 elixirc.1 iex.1 mix.1; do
		install -Dm600 "$CLANDRO_PREFIX/opt/elixir/man/$page" \
			"$CLANDRO_PREFIX/share/man/man1/$page"
	done
	unset page
	rm -rf "$CLANDRO_PREFIX"/opt/elixir/man

	# Symlink startup scripts to $PREFIX/bin.
	for file in elixir elixirc iex mix; do
		ln -sfr "$CLANDRO_PREFIX/opt/elixir/bin/$file" \
			"$CLANDRO_PREFIX/bin/$file"
	done
	unset file
}
