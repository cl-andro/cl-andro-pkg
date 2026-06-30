CLANDRO_PKG_HOMEPAGE=https://www.inf.puc-rio.br/~roberto/lpeg
CLANDRO_PKG_DESCRIPTION="Pattern-matching library for Lua 5.4"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.1.0"
_rock_revision=2
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL="https://luarocks.org/manifests/gvvaughan/lpeg-$CLANDRO_PKG_VERSION-$_rock_revision.src.rock"
CLANDRO_PKG_SHA256=836d315b920a5cdd62e21786c6c9fad547c4faa131d5583ebca64f0b6595ee76
CLANDRO_PKG_BUILD_DEPENDS="lua51, lua52, lua53, lua54, lua55"
CLANDRO_PKG_DEPENDS="lua55"

clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL}")"
	local folder
	set +o pipefail
	folder=$(unzip -qql "$file" | head -n1 | tr -s ' ' | cut -d' ' -f5-)
	rm -Rf "$folder"
	unzip -q "$file"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar xf "$CLANDRO_PKG_TMPDIR/lpeg-${CLANDRO_PKG_VERSION%-*}.tar.gz" -C "$CLANDRO_PKG_SRCDIR" --strip-components=1
	set -o pipefail
}

clandro_step_pre_configure() {
	declare -ag LUA=('5.1' '5.2' '5.3' '5.4' '5.5')
	for lua in "${LUA[@]}"; do
		cp -r "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/lpeg-${lua//./}"
	done
}

clandro_step_make() {
	for lua in "${LUA[@]}"; do
		cd "${CLANDRO_PKG_BUILDDIR}/lpeg-${lua//./}" || :
		make \
			CC="$CC" \
			CFLAGS="$CFLAGS -fPIC -I$CLANDRO_PREFIX/include/lua$lua" \
			LDFLAGS="$LDFLAGS -L$CLANDRO_PREFIX/lib/lua/$lua -llua$lua" \
			LUADIR="$CLANDRO_PREFIX/include/lua/$lua" LUAVER="$lua"
	done
}

clandro_step_make_install() {
	sed -Ei 's|"(lp.+\.h)"|"lpeg/\1"|' "${CLANDRO_PKG_SRCDIR}"/*.h
	install -Dm600 -t "${CLANDRO_PREFIX}/include/lpeg" "${CLANDRO_PKG_SRCDIR}"/*.h
	for lua in "${LUA[@]}"; do
		install -Dm600 lpeg-"${lua//./}"/liblpeg.so "$CLANDRO_PREFIX/lib/liblpeg-$lua".so
		mkdir -p "${CLANDRO_PREFIX}/lib/lua/$lua"
		ln -sf "${CLANDRO_PREFIX}/lib/liblpeg-$lua.so" "${CLANDRO_PREFIX}/lib/lua/$lua/lpeg.so"
		install -Dm600 lpeg-"${lua//./}"/re.lua "$CLANDRO_PREFIX/share/lua/$lua"/re.lua
	done
	# make liblpeg-5.5.so the default one
	ln -sf "${CLANDRO_PREFIX}/lib/liblpeg-5.5.so" "${CLANDRO_PREFIX}/lib/liblpeg.so"
}
