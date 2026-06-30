CLANDRO_PKG_HOMEPAGE=https://www.gimp.org/
CLANDRO_PKG_DESCRIPTION="GNU Image Manipulation Program"
CLANDRO_PKG_LICENSE="GPL-3.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://gitlab.gnome.org/GNOME/gimp
CLANDRO_PKG_GIT_BRANCH="GIMP_${CLANDRO_PKG_VERSION//./_}"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="aalib, appstream, appstream-glib, atk, babl, fontconfig, freetype, gdk-pixbuf, gegl, gexiv2, ghostscript, gimp-data, glib, glib-networking, gtk3, harfbuzz, hicolor-icon-theme, imath, json-glib, libandroid-execinfo, libandroid-shmem, libbz2, libc++, libcairo, libheif, libjpeg-turbo, libjxl, libmypaint, libpng, librsvg, libtiff, libwebp, libxcursor, libxmu, libxpm, littlecms, mypaint-brushes, openexr, openjpeg, pango, poppler, poppler-data, pygobject, zlib"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs"
CLANDRO_PKG_SUGGESTS="gimp-resynthesizer"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dcheck-update=no
-Dvala=disabled
-Dcan-crosscompile-gir=true
-Dopenmp=disabled
-Dicc-directory=$CLANDRO_PREFIX/share/color/icc
-Dlibunwind=false
-Dlibbacktrace=false
-Dmng=disabled
-Dwmf=disabled
-Dgi-docgen=disabled
-Djavascript=disabled
-Dlua=false
-Dbug-report-url=https://github.com/termux/termux-packages/issues/new?template=01-bug-report.yml
"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_proot
	CXXFLAGS+=" -Wno-error=register"
	LDFLAGS+=" -landroid-shmem -lm"
	export GLIB_COMPILE_RESOURCES=glib-compile-resources

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		# Gimp requires using cross-compiled or prebuilt gimp during cross-compilation which is hard to achive here
		# gimp is required only to generate splash image, so it will be fine to use official appimage.
		clandro_download https://download.gimp.org/gimp/v${CLANDRO_PKG_VERSION%.*}/linux/GIMP-${CLANDRO_PKG_VERSION}-x86_64.AppImage "$CLANDRO_PKG_CACHEDIR/gimp.appimage" e7794ebd6ed90fe32f6dede3917216aaceee833bdc794f2a0fe925e1d96cc899
		chmod +x "$CLANDRO_PKG_CACHEDIR/gimp.appimage"
		[ -d $CLANDRO_PKG_CACHEDIR/squashfs-root ] || (cd "$CLANDRO_PKG_CACHEDIR"; "$CLANDRO_PKG_CACHEDIR/gimp.appimage" --appimage-extract)

		# For some reason gimp-console-3.0 always tries to open X11 display.
		# See https://gitlab.gnome.org/GNOME/gimp/-/issues/13537
		# sed -i 's/org.gimp.GIMP.Stable/gimp-console-3.0/g' "$CLANDRO_PKG_CACHEDIR/squashfs-root/AppRun" ||:
		# "$CLANDRO_PKG_CACHEDIR/squashfs-root/AppRun" -nidfs "$CLANDRO_PKG_SRCDIR/gimp-data/images/gimp-splash.xcf.gz" \
		#	--batch-interpreter python-fu-eval -b - --quit < "$CLANDRO_PKG_SRCDIR/gimp-data/images/export-splash.py" > "$CLANDRO_PKG_SRCDIR/gimp-data/images/gimp-splash.png"

		# As a workaround we will simply extract splash from appimage.
		cp "$CLANDRO_PKG_CACHEDIR/squashfs-root/usr/share/gimp/3.0/images/gimp-splash.png" "$CLANDRO_PKG_SRCDIR/gimp-data/images/gimp-splash.png"

		mkdir -p "$CLANDRO_PKG_TMPDIR/bin"
		# gtk-encode-symbolic-svg is required but not installed in our docker image.
		cat > "$CLANDRO_PKG_TMPDIR/bin/gtk-encode-symbolic-svg" <<-HERE
			#!$(command -v bash)
			# proot will append its own LD_LIBRARY_PATH which is incompatible with bionic
			exec $(command -v termux-proot-run) env LD_PRELOAD= LD_LIBRARY_PATH= $CLANDRO_PREFIX/bin/gtk-encode-symbolic-svg "\$@"
		HERE
		cat > "$CLANDRO_PKG_TMPDIR/bin/gimp-console-3.0" <<-HERE
			#!$(command -v bash)
			unset GI_TYPELIB_PATH LD_LIBRARY_PATH
			exec $CLANDRO_PKG_CACHEDIR/squashfs-root/AppRun "\$@"
		HERE
		# for some reason deb-elf-get-needed fails on x86_64
		cat > "$CLANDRO_PKG_TMPDIR/bin/g-ir-scanner" <<-HERE
			#!$(command -v bash)
			exec $(unset PKG_CONFIG_DIR PKG_CONFIG_LIBDIR; /usr/bin/pkg-config --variable=g_ir_scanner gobject-introspection-1.0) "\$@" --use-ldd-wrapper=$(command -v ldd)
		HERE
		# meson cross-file already has pkg-config defined so termux's pkg-config wrapper will be used for cross-compilation.
		# but we must have regular pkg-config to allow meson linking `native: true` targets.
		# Also we should override host's g-ir-scanner
		cat > "$CLANDRO_PKG_TMPDIR/bin/pkg-config" <<-HERE
			#!$(command -v bash)
			unset PKG_CONFIG_DIR PKG_CONFIG_LIBDIR
			if [ "\$1" = "--variable=g_ir_scanner" ] && [ "\$2" = "gobject-introspection-1.0" ]; then
				echo "$CLANDRO_PKG_TMPDIR/bin/g-ir-scanner"
				exit 0
			fi
			exec /usr/bin/pkg-config "\$@"
		HERE
		chmod +x "$CLANDRO_PKG_TMPDIR/bin"/*
		PATH="$CLANDRO_PKG_TMPDIR/bin:$PATH"
	fi
}

clandro_step_post_configure() {
	sed -i 's/#define HAVE_OPENMP/#undef HAVE_OPENMP/g' "$CLANDRO_PKG_BUILDDIR/config.h"
}
