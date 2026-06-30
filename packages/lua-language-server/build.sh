CLANDRO_PKG_HOMEPAGE="https://github.com/sumneko/lua-language-server"
CLANDRO_PKG_DESCRIPTION="Sumneko Lua Language Server coded in Lua"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.18.2"
CLANDRO_PKG_GIT_BRANCH="${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_SRCURL="git+https://github.com/sumneko/lua-language-server"
# `lua-language-server` links against libbfd,
# remember to rebuild it when updating `binutils`.
CLANDRO_PKG_DEPENDS="binutils, libandroid-spawn, libc++"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

_patch_on_device() {
	if [ "${CLANDRO_ON_DEVICE_BUILD}" = true ]; then
		(
			cd "${CLANDRO_PKG_SRCDIR}"
			patch --silent -p1 < "${CLANDRO_PKG_BUILDER_DIR}"/android.diff
		)
	fi
}

_load_ubuntu_packages() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		export HOSTBUILD_ROOTFS="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages"
		export LD_LIBRARY_PATH="${HOSTBUILD_ROOTFS}/usr/lib/x86_64-linux-gnu"
		LD_LIBRARY_PATH+=":${HOSTBUILD_ROOTFS}/usr/lib"
	fi
}

clandro_step_host_build() {
	_patch_on_device
	clandro_setup_ninja

	mkdir 3rd
	cp -a "${CLANDRO_PKG_SRCDIR}"/3rd/luamake 3rd/

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		local -a ubuntu_packages=(
			"binutils"
			"binutils-common"
			"binutils-dev"
			"binutils-x86-64-linux-gnu"
			"libbinutils"
			"libctf-nobfd0"
			"libctf0"
			"libgprofng0"
			"libsframe1"
			"libunwind-dev"
			"libunwind8"
		)

		clandro_download_ubuntu_packages "${ubuntu_packages[@]}"

		_load_ubuntu_packages

		patch="$CLANDRO_PKG_BUILDER_DIR/hostbuild-force-link.diff"
		echo "Applying patch: $(basename "$patch")"
		test -f "$patch" && sed \
			-e "s%\@CLANDRO_PKG_HOSTBUILD_DIR\@%${CLANDRO_PKG_HOSTBUILD_DIR}%g" \
			"$patch" | patch --silent -p1
	fi

	cd 3rd/luamake
	./compile/install.sh
}

clandro_step_make() {
	clandro_setup_ninja

	CFLAGS+=" -DBEE_ENABLE_FILESYSTEM"     # without this, it tries to link against its own filesystem lib and fails.
	CFLAGS+=" -Wno-unknown-warning-option" # for -Wno-maybe-uninitialized argument.

	sed \
		-e "s%\@FLAGS\@%${CFLAGS} ${CPPFLAGS}%g" \
		-e "s%\@LDFLAGS\@%${LDFLAGS}%g" \
		"${CLANDRO_PKG_BUILDER_DIR}"/make.lua.diff | patch --silent -p1

	_load_ubuntu_packages

	patch="$CLANDRO_PKG_BUILDER_DIR/force-cast-unw_context_t.diff"
	echo "Applying patch: $(basename "$patch")"
	test -f "$patch" && {
		patch --silent -p1 -d "$CLANDRO_PKG_SRCDIR/3rd/bee.lua/bee/crash/linux" < "$patch"
		patch --silent -p1 -d "$CLANDRO_PKG_SRCDIR/3rd/luamake/bee.lua/bee/crash/linux" < "$patch"
	}

	"${CLANDRO_PKG_HOSTBUILD_DIR}"/3rd/luamake/luamake \
		-cc "${CC}" \
		-hostos "android"
}

clandro_step_make_install() {
	local datadir="${CLANDRO_PREFIX}/share/${CLANDRO_PKG_NAME}"

	cat > "${CLANDRO_PREFIX}/bin/${CLANDRO_PKG_NAME}" <<- EOF
		#!${CLANDRO_PREFIX}/bin/bash
		TMPPATH="\$(mktemp -d "${CLANDRO_PREFIX}/tmp/${CLANDRO_PKG_NAME}.XXXX")"

		exec ${datadir}/bin/${CLANDRO_PKG_NAME} \\
		--logpath="\${TMPPATH}/log" \\
		--metapath="\${TMPPATH}/meta" \\
		"\${@}"
	EOF

	chmod 0700 "${CLANDRO_PREFIX}/bin/${CLANDRO_PKG_NAME}"

	install -Dm700 -t "${datadir}"/bin ./bin/"${CLANDRO_PKG_NAME}"
	install -Dm600 -t "${datadir}" ./{main,debugger}.lua
	install -Dm600 -t "${datadir}"/bin ./bin/main.lua

	# needed for --version
	install -Dm600 -t "${datadir}" ./changelog.md

	cp -r ./script ./meta ./locale "${datadir}"
}
