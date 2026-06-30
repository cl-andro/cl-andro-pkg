CLANDRO_PKG_HOMEPAGE=http://simh.trailing-edge.com/
CLANDRO_PKG_DESCRIPTION="A collection of simulators for computer hardware and software from the past"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
_VERSION=3.12-5
CLANDRO_PKG_VERSION=1:${_VERSION/-/.}
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://simh.trailing-edge.com/sources/simhv${_VERSION/.}.zip
CLANDRO_PKG_SHA256=561524723b5979c4ba6d1ed58fd33749c47ac2934eba55d98c48f558b71f3ee8
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="DONT_USE_ROMS=1 TESTS=0"

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/LICENSE ./
}

clandro_step_pre_configure() {
	CFLAGS+=" -fcommon -fwrapv"
	LDFLAGS+=" -lm"
}

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES \
		GCC="$CC" CFLAGS_O="$CFLAGS $CPPFLAGS" LDFLAGS="$LDFLAGS" \
		$CLANDRO_PKG_EXTRA_MAKE_ARGS
}

clandro_step_make_install() {
	shopt -s nullglob
	for f in BIN/*; do
		if [ -f "$f" ]; then
			local b="$(basename "$f")"
			install -Dm700 -T "$f" $CLANDRO_PREFIX/bin/simh-"$b"
		fi
	done
	for f in */*.bin; do
		install -Dm600 -T "$f" $CLANDRO_PREFIX/share/simh/"$f"
	done
	shopt -u nullglob
}
