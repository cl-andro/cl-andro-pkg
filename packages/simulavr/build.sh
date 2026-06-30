CLANDRO_PKG_HOMEPAGE="https://www.nongnu.org/simulavr"
CLANDRO_PKG_DESCRIPTION="Simulator for Microchip AVR (formerly Atmel) microcontrollers"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_VERSION_MAJOR=1
_VERSION_MINOR=1
_VERSION_PATCH=0
CLANDRO_PKG_VERSION=1:${_VERSION_MAJOR}.${_VERSION_MINOR}.${_VERSION_PATCH}
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="git+https://git.savannah.nongnu.org/git/simulavr"
CLANDRO_PKG_GIT_BRANCH=release-${CLANDRO_PKG_VERSION#*:}
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS='
-DBUILD_TCL=OFF
-DBUILD_PYTHON=OFF
-DBUILD_VERILOG=OFF
-DCHECK_VALGRIND=OFF
'

clandro_step_post_get_source() {
	echo "Applying hardcode-version.diff"
	sed \
		-e "s|@VERSION_MAJOR@|${_VERSION_MAJOR}|g" \
		-e "s|@VERSION_MINOR@|${_VERSION_MINOR}|g" \
		-e "s|@VERSION_PATCH@|${_VERSION_PATCH}|g" \
		$CLANDRO_PKG_BUILDER_DIR/hardcode-version.diff \
		| patch --silent -p1
}

clandro_step_make_install() {
	install -DTm755 "$CLANDRO_PKG_BUILDDIR"/app/"$CLANDRO_PKG_NAME" \
		"$CLANDRO_PREFIX"/bin/"$CLANDRO_PKG_NAME"
	install -Dm644 "$CLANDRO_PKG_BUILDDIR"/libsim/libsim.so \
		-t "$CLANDRO_PREFIX"/lib/
	install -Dm644 "$CLANDRO_PKG_BUILDDIR"/doc/{copyright,SUPPORT,AUTHORS,README.gdb,NEWS,TODO,README} \
		-t "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME"
	install -DTm644 "$CLANDRO_PKG_BUILDDIR"/doc/COPYING \
		"$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME"/LICENSE
	# Headers are moved into their own subdirectory to prevent conflicts.
	# Might cause issues when using them.
	cp -rf "$CLANDRO_PKG_BUILDDIR"/include/ "$CLANDRO_PREFIX"/include/"$CLANDRO_PKG_NAME"
}
