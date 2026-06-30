CLANDRO_PKG_HOMEPAGE=https://yosyshq.net/yosys/
CLANDRO_PKG_DESCRIPTION="A framework for RTL synthesis tools"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.64"
CLANDRO_PKG_SRCURL=git+https://github.com/YosysHQ/yosys
CLANDRO_PKG_GIT_BRANCH="v$CLANDRO_PKG_VERSION"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+(.\d+)?"
CLANDRO_PKG_DEPENDS="graphviz, libandroid-glob, libandroid-spawn, libc++, libffi, ncurses, readline, tcl, zlib, python"
CLANDRO_PKG_BUILD_DEPENDS="flex"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX ENABLE_PYOSYS=0 PYOSYS_USE_UV=0"

clandro_step_pre_configure() {
	export LIBS="-Wl,-rpath=$CLANDRO_PREFIX/lib -landroid-glob -landroid-spawn"
	export PATH="$CLANDRO_PKG_TMPDIR:$PATH"

	echo "#!$(readlink /proc/$$/exe)" > "$CLANDRO_PKG_TMPDIR/python3-config"
	echo "exec \"$CLANDRO_PREFIX/bin/python3-config\" \"\$@\"" >> "$CLANDRO_PKG_TMPDIR/python3-config"
	chmod +x "$CLANDRO_PKG_TMPDIR/python3-config"
	ln -sf "$(command -v $STRIP)" "$CLANDRO_PKG_TMPDIR/strip"
	rm "$CLANDRO_PKG_SRCDIR"/{setup.py,pyproject.toml}
}
