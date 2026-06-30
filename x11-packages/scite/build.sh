CLANDRO_PKG_HOMEPAGE=https://www.scintilla.org/SciTE.html
CLANDRO_PKG_DESCRIPTION="A free source code editor"
CLANDRO_PKG_LICENSE="HPND"
CLANDRO_PKG_LICENSE_FILE="scite/License.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.6.2"
CLANDRO_PKG_SRCURL=https://www.scintilla.org/scite${CLANDRO_PKG_VERSION//./}.tgz
CLANDRO_PKG_SHA256=f46a77b0d4972dc51c857bab3fe55a8e47cae481737359f93aef98ccca56de1d
CLANDRO_PKG_DEPENDS="at-spi2-core, gdk-pixbuf, glib, gtk3, libc++, libcairo, pango"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
CLANG=1
GTK3=1
NO_LUA=1
"

clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$file" -C "$CLANDRO_PKG_SRCDIR" --strip-components=0
}

clandro_step_pre_configure() {
	# https://github.com/termux/termux-packages/issues/18810
	LDFLAGS+=" -Wl,--undefined-version"
}

clandro_step_make() {
	local d
	for d in lexilla/src scintilla/gtk scite/gtk; do
		make -j ${CLANDRO_PKG_MAKE_PROCESSES} -C ${d} \
			${CLANDRO_PKG_EXTRA_MAKE_ARGS}
	done
}

clandro_step_make_install() {
	make -j ${CLANDRO_PKG_MAKE_PROCESSES} -C scite/gtk install \
		${CLANDRO_PKG_EXTRA_MAKE_ARGS}
}
