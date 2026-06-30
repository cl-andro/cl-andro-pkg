CLANDRO_PKG_HOMEPAGE=https://luajit.org/
CLANDRO_PKG_DESCRIPTION="Just-In-Time Compiler for Lua"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:2.1.1774896198+g18b087c"
CLANDRO_PKG_SRCURL=git+https://github.com/LuaJIT/LuaJIT.git
CLANDRO_PKG_GIT_BRANCH=v${CLANDRO_PKG_VERSION:2:3}
CLANDRO_PKG_BREAKS="libluajit-dev, libluajit"
CLANDRO_PKG_REPLACES="libluajit-dev, libluajit"
CLANDRO_PKG_EXTRA_MAKE_ARGS="amalg PREFIX=$CLANDRO_PREFIX"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_pkg_auto_update() {
	local latest_version current_version="${CLANDRO_PKG_VERSION#*:}"
	latest_version="$(
		CLANDRO_PKG_SRCURL="https://gitlab.archlinux.org/archlinux/packaging/packages/luajit" \
		clandro_gitlab_api_get_tag
	)"

	# Remove the -${rev} from the tag
	latest_version="${latest_version%-*}"

	# Use +g${hash} for the commit portion of the version
	clandro_pkg_upgrade_version "${latest_version/+/+g}"
}

clandro_step_post_get_source() {
	local expected_commit="${CLANDRO_PKG_VERSION##*+g}"
	local expected_timestamp="${CLANDRO_PKG_VERSION##*.}"
	expected_timestamp="${expected_timestamp%+g*}"

	# Remember to pull in the necessary amount of git history
	git fetch --shallow-since="$expected_timestamp"

	local actual_commit actual_timestamp
	actual_timestamp="$(git show --no-patch --pretty=format:%at "$expected_commit" --)"
	actual_commit="$(git log --date=unix --before="$expected_timestamp" --after="$expected_timestamp" --pretty=format:"%H")"

	if [[ "${actual_commit::7}" != "${expected_commit::7}" ]]; then
		clandro_error_exit <<-EOF

			ERROR: Expected and observed commit at timestamp don't match.
			Expected: '${expected_commit::7}' @$expected_timestamp ($(date -d "@$expected_timestamp" --utc '+%Y-%m-%dT%H:%M:%SZ'))
			Got:      '${actual_commit::7}' @$actual_timestamp ($(date -d "@$actual_timestamp" --utc '+%Y-%m-%dT%H:%M:%SZ'))
		EOF
	fi

	git checkout "$actual_commit"
}

clandro_step_pre_configure() {
	# luajit wants same pointer size for host and target build
	export HOST_CC="gcc"
	if (( CLANDRO_ARCH_BITS == 32 )); then
		export HOST_CFLAGS="-m32"
		export HOST_LDFLAGS="-m32"
	fi
	export TARGET_FLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
	export TARGET_SYS=Linux
	unset CFLAGS LDFLAGS
}

clandro_step_make_install () {
	local LUAJIT_MINOR_VERSION="${CLANDRO_PKG_VERSION:2:3}"

	mkdir -p "$CLANDRO_PREFIX/include/luajit-${LUAJIT_MINOR_VERSION}/"
	cp -f "$CLANDRO_PKG_SRCDIR"/src/{lauxlib.h,lua.h,lua.hpp,luaconf.h,luajit.h,lualib.h} "$CLANDRO_PREFIX/include/luajit-${LUAJIT_MINOR_VERSION}/"
	rm -f "$CLANDRO_PREFIX"/lib/libluajit*

	install -Dm600 "$CLANDRO_PKG_SRCDIR/src/libluajit.so" "$CLANDRO_PREFIX/lib/libluajit-5.1.so.${LUAJIT_MINOR_VERSION}.0"
	install -Dm600 "$CLANDRO_PKG_SRCDIR/src/libluajit.a" "$CLANDRO_PREFIX/lib/libluajit-5.1.a"
	( # shellcheck disable=SC2164 # We run with `set -eu` so if the cd fails the script exits anyway.
		cd "$CLANDRO_PREFIX/lib"
		ln -sf "libluajit-5.1.so.${LUAJIT_MINOR_VERSION}.0" libluajit.so
		ln -sf "libluajit-5.1.so.${LUAJIT_MINOR_VERSION}.0" libluajit-5.1.so
		ln -sf "libluajit-5.1.so.${LUAJIT_MINOR_VERSION}.0" libluajit-5.1.so.2
		ln -sf libluajit-5.1.a libluajit.a
	)

	install -Dm600 "$CLANDRO_PKG_SRCDIR/etc/luajit.1" "$CLANDRO_PREFIX/share/man/man1/luajit.1"
	install -Dm600 "$CLANDRO_PKG_SRCDIR/etc/luajit.pc" "$CLANDRO_PREFIX/lib/pkgconfig/luajit.pc"
	install -Dm700 "$CLANDRO_PKG_SRCDIR/src/luajit" "$CLANDRO_PREFIX/bin/luajit"

	# Files needed for the -b option (http://luajit.org/running.html) to work.
	local CLANDRO_LUAJIT_DIR="$CLANDRO_PREFIX/share/luajit-${LUAJIT_MINOR_VERSION}/jit"
	mkdir -p "$CLANDRO_LUAJIT_DIR"
	cp -v "$CLANDRO_PKG_SRCDIR"/src/jit/*lua "$CLANDRO_LUAJIT_DIR"
}
