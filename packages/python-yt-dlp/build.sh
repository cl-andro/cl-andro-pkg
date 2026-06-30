CLANDRO_PKG_HOMEPAGE=https://github.com/yt-dlp/yt-dlp
CLANDRO_PKG_DESCRIPTION="A youtube-dl fork with additional features and fixes"
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2026.03.17"
CLANDRO_PKG_SRCURL=https://github.com/yt-dlp/yt-dlp/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=924483986441d8a1e669a0e4371d753a9256ce4bdc06032394ccb7b793342434
CLANDRO_PKG_DEPENDS="libc++, libexpat, openssl, python, python-brotli, python-pip, python-pycryptodomex"
CLANDRO_PKG_RECOMMENDS="ffmpeg, yt-dlp-ejs"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="hatchling, wheel"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PROVIDES='yt-dlp'
CLANDRO_PKG_CONFFILES="etc/yt-dlp/config"

clandro_step_host_build() {
	cp -Rf $CLANDRO_PKG_SRCDIR ./

	( cd src && make completions )
}

clandro_step_make() {
	:
}

clandro_step_make_install() {
	# Install library
	pip install . --prefix=$CLANDRO_PREFIX -vv --no-build-isolation --no-deps

	# Install completions
	install -Dm600 $CLANDRO_PKG_HOSTBUILD_DIR/src/completions/bash/yt-dlp \
		-t "$CLANDRO_PREFIX"/share/bash-completion/completions
	install -Dm600 $CLANDRO_PKG_HOSTBUILD_DIR/src/completions/zsh/_yt-dlp \
		-t "$CLANDRO_PREFIX"/share/zsh/site-functions
	install -Dm600 $CLANDRO_PKG_HOSTBUILD_DIR/src/completions/fish/yt-dlp.fish \
		-t "$CLANDRO_PREFIX"/share/fish/completions

	# Install config file
	if (( CLANDRO_ARCH_BITS == 32 )); then
		mkdir -p "$CLANDRO_PREFIX/etc/yt-dlp"
		cat <<- EOF > "$CLANDRO_PREFIX/etc/yt-dlp/config"
		# yt-dlp-ejs defaults to using Deno as the JS runtime,
		# Deno doesn't currently have 32 bit build support.
		# So use Node instead on '$CLANDRO_ARCH'.
		--js-runtimes node
		EOF
	fi
}
