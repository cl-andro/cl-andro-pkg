CLANDRO_PKG_HOMEPAGE=https://fishshell.com/
CLANDRO_PKG_DESCRIPTION="The user-friendly command line shell"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.7.1"
CLANDRO_PKG_SRCURL=https://github.com/fish-shell/fish-shell/releases/download/$CLANDRO_PKG_VERSION/fish-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6f4d5b438a6338e3f5dcda19a28261e2ece7a9b7ff97686685e6abdc31dbb7df
# fish calls 'tput' from ncurses-utils, at least when cancelling (Ctrl+C) a command line.
# man is needed since fish calls apropos during command completion.
CLANDRO_PKG_DEPENDS="bc, libandroid-support, libc++, mandoc, ncurses, ncurses-utils, pcre2"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_DOCS=OFF
-DFISH_USE_SYSTEM_PCRE2=ON
-DMAC_CODESIGN_ID=OFF
-DWITH_MESSAGE_LOCALIZATION=OFF
"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_rust

	# FindRust.cmake auto pick thumbv7neon-linux-androideabi
	[[ "${CLANDRO_ARCH}" == "arm" ]] && CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_ANDROID_ARM_MODE=ON"

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DRust_CARGO_TARGET=$CARGO_TARGET_NAME"

	# older than Android 8 dont have ctermid
	"${CC}" ${CPPFLAGS} ${CFLAGS} -c ${CLANDRO_PKG_BUILDER_DIR}/ctermid.c
	"${AR}" cru libctermid.a ctermid.o

	# cmake invokes rustc directly leaving CARGO_TARGET_*_RUSTFLAGS unused
	local -u env_host="${CARGO_TARGET_NAME//-/_}"
	export RUSTFLAGS=$(env | grep CARGO_TARGET_${env_host}_RUSTFLAGS | cut -d'=' -f2-)
	RUSTFLAGS+=" -C link-arg=-landroid-spawn"
	RUSTFLAGS+=" -L${CLANDRO_PKG_BUILDDIR} -C link-arg=-l:libctermid.a"
}

clandro_step_post_make_install() {
	cat >> "$CLANDRO_PREFIX/etc/fish/config.fish" <<-EOF
	function __fish_command_not_found_handler --on-event fish_command_not_found
		$CLANDRO_PREFIX/libexec/termux/command-not-found \$argv[1]
	end
	EOF
}
