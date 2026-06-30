CLANDRO_PKG_HOMEPAGE=https://docbook.org/
CLANDRO_PKG_DESCRIPTION="XML stylesheets for Docbook-xml transformations"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.79.2
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_LICENSE_FILE="docbook-xsl-${CLANDRO_PKG_VERSION}/COPYING, docbook-xsl-nons-${CLANDRO_PKG_VERSION}/COPYING"
CLANDRO_PKG_DEPENDS="docbook-xml (>= 5.1), libxml2-utils, xsltproc"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true

clandro_step_get_source() {
	mkdir -p $CLANDRO_PKG_SRCDIR

	cd $CLANDRO_PKG_SRCDIR

	clandro_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${CLANDRO_PKG_VERSION}/docbook-xsl-$CLANDRO_PKG_VERSION.tar.gz" \
		$CLANDRO_PKG_CACHEDIR/docbook-xsl-$CLANDRO_PKG_VERSION.tar.gz \
		966188d7c05fc76eaca115a55893e643dd01a3486f6368733c9ad974fcee7a26

	tar xf $CLANDRO_PKG_CACHEDIR/docbook-xsl-$CLANDRO_PKG_VERSION.tar.gz

	clandro_download "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F${CLANDRO_PKG_VERSION}/docbook-xsl-nons-$CLANDRO_PKG_VERSION.tar.gz" \
		$CLANDRO_PKG_CACHEDIR/docbook-xsl-nons-$CLANDRO_PKG_VERSION.tar.gz \
		f89425b44e48aad24319a2f0d38e0cb6059fdc7dbaf31787c8346c748175ca8e

	tar xf $CLANDRO_PKG_CACHEDIR/docbook-xsl-nons-$CLANDRO_PKG_VERSION.tar.gz
}

clandro_step_patch_package() {
	cd $CLANDRO_PKG_SRCDIR/docbook-xsl-$CLANDRO_PKG_VERSION
	patch -Np2 -i $CLANDRO_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch

	cd $CLANDRO_PKG_SRCDIR/docbook-xsl-nons-$CLANDRO_PKG_VERSION
	patch -Np2 -i $CLANDRO_PKG_BUILDER_DIR/765567_non-recursive_string_subst.patch
}

clandro_step_make_install() {
	local pkgroot ns dir

	for ns in -nons ''; do
		pkgroot="$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-${CLANDRO_PKG_VERSION}${ns}"
		dir=docbook-xsl${ns}-${CLANDRO_PKG_VERSION}

		install -Dt "$pkgroot" -m600 $dir/VERSION{,.xsl}

		(
			shopt -s nullglob  # ignore missing files
			for fn in assembly common eclipse epub epub3 fo highlighting html \
				htmlhelp javahelp lib manpages params profiling roundtrip template \
				website xhtml xhtml-1_1 xhtml5
			do
				install -Dt "${pkgroot}/${fn}" -m600 ${dir}/${fn}/*.{xml,xsl,dtd,ent}
			done
		)
	done
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ]; then
		if [ ! -e "$CLANDRO_PREFIX/etc/xml/catalog" ]; then
			xmlcatalog --noout --create "$CLANDRO_PREFIX/etc/xml/catalog"
		else
			xmlcatalog --noout --del "$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-$CLANDRO_PKG_VERSION" \
				"$CLANDRO_PREFIX/etc/xml/catalog"
		fi

		for ver in $CLANDRO_PKG_VERSION current; do
			for x in rewriteSystem rewriteURI; do
				xmlcatalog --noout --add \$x http://cdn.docbook.org/release/xsl/\$ver \
					"$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-$CLANDRO_PKG_VERSION" \
					"$CLANDRO_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl-ns/\$ver \
					"$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-$CLANDRO_PKG_VERSION" \
					"$CLANDRO_PREFIX/etc/xml/catalog"

				xmlcatalog --noout --add \$x http://docbook.sourceforge.net/release/xsl/\$ver \
					"$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-${CLANDRO_PKG_VERSION}-nons" \
					"$CLANDRO_PREFIX/etc/xml/catalog"
			done
		done
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh
	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "remove" ]; then
		xmlcatalog --noout --del "$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-$CLANDRO_PKG_VERSION" \
			"$CLANDRO_PREFIX/etc/xml/catalog"
	fi
	EOF
}
