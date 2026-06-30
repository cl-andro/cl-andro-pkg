CLANDRO_PKG_HOMEPAGE=https://www.tug.org/texlive/
CLANDRO_PKG_DESCRIPTION="Wrapper around texlive's install-tl script"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="20260301"
CLANDRO_PKG_SRCURL="https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${CLANDRO_PKG_VERSION:0:4}/install-tl-unx.tar.gz"
CLANDRO_PKG_SHA256=5cc0703d6fe49f00a2932c4e3bcee37a11cc0a969ae9fcbf9cad6f0d984d6363
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_DEPENDS="perl, texlive-bin (>= 20240310), gnupg, curl, lz4, xz-utils"
CLANDRO_PKG_REPLACES="texlive"
CLANDRO_PKG_BREAKS="texlive"
CLANDRO_PKG_RM_AFTER_INSTALL="
opt/texlive/install-tl/texmf-dist
opt/texlive/install-tl/tlpkg/installer/curl
opt/texlive/install-tl/tlpkg/installer/wget
opt/texlive/install-tl/tlpkg/installer/xz
"

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/opt/texlive
	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/installer.sh \
		> $CLANDRO_PREFIX/bin/termux-install-tl
	chmod 700 $CLANDRO_PREFIX/bin/termux-install-tl

	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@YEAR@|${CLANDRO_PKG_VERSION:0:4}|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/termux-patch-texlive.sh \
		> $CLANDRO_PREFIX/bin/termux-patch-texlive
	chmod 700 $CLANDRO_PREFIX/bin/termux-patch-texlive

	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@YEAR@|${CLANDRO_PKG_VERSION:0:4}|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/termux.profile \
		> $CLANDRO_PREFIX/opt/texlive/termux.profile
	chmod 600 $CLANDRO_PREFIX/opt/texlive/termux.profile

	for DIFF in "$CLANDRO_PKG_BUILDER_DIR"/*.diff; do
		sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
			-e "s|@YEAR@|${CLANDRO_PKG_VERSION:0:4}|g" $DIFF \
			> $CLANDRO_PREFIX/opt/texlive/$(basename $DIFF)
		chmod 600 $CLANDRO_PREFIX/opt/texlive/$(basename $DIFF)
	done

	if [ -d "$CLANDRO_PREFIX/opt/texlive/install-tl" ]; then
		rm -r "$CLANDRO_PREFIX/opt/texlive/install-tl"
	fi
	cp -r $CLANDRO_PKG_SRCDIR/ $CLANDRO_PREFIX/opt/texlive/install-tl

	mkdir -p $CLANDRO_PREFIX/etc/profile.d/ $CLANDRO_PREFIX/etc/fish/conf.d/
	{
		echo "export PATH=\$PATH:$CLANDRO_PREFIX/bin/texlive"
		echo "export TEXMFROOT=$CLANDRO_PREFIX/share/texlive/${CLANDRO_PKG_VERSION:0:4}"
		echo "export TEXMFLOCAL=$CLANDRO_PREFIX/share/texlive/texmf-local"
		echo "export OSFONTDIR=$CLANDRO_PREFIX/share/fonts/TTF"
		echo "export TRFONTS=$CLANDRO_PREFIX/share/groff/{current/font,site-font}/devps"
	} > $CLANDRO_PREFIX/etc/profile.d/texlive.sh
	{
		echo "set -gx --append PATH $CLANDRO_PREFIX/bin/texlive"
		echo "set -gx TEXMFROOT $CLANDRO_PREFIX/share/texlive/${CLANDRO_PKG_VERSION:0:4}"
		echo "set -gx TEXMFLOCAL $CLANDRO_PREFIX/share/texlive/texmf-local"
		echo "set -gx OSFONTDIR $CLANDRO_PREFIX/share/fonts/TTF"
		echo "set -gx TRFONTS $CLANDRO_PREFIX/share/groff/current/font/devps $CLANDRO_PREFIX/share/groff/site-font/devps"
	} > $CLANDRO_PREFIX/etc/fish/conf.d/texlive.fish
}

clandro_step_create_debscripts() {
	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "echo ''"
		echo "echo '[*] You can now run the texlive installer by running'"
		echo "echo ''"
		echo "echo '      termux-install-tl'"
		echo "echo ''"
		echo "echo '    It forwards extra arguments to the install-tl script.'"
		echo "echo ''"
		echo "echo '    NOTE: texlive-${CLANDRO_PKG_VERSION:0:4} is installed into \$PREFIX/share/texlive/${CLANDRO_PKG_VERSION:0:4}'"
		echo "echo '          If you have an old version installed you can rm -rf \$PREFIX/share/texlive/202X to'"
		echo "echo '          delete (most of) old version and free up space.'"
	} > ./postinst
}
