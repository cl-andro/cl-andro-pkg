CLANDRO_PKG_HOMEPAGE="https://github.com/ericsink/SQLitePCL.raw"
CLANDRO_PKG_DESCRIPTION="SQLitePCLRaw is a Portable Class Library for low-level access to SQLite (native library)"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT="cd2922b8867e4360f0976601414bd24a3ad613d8"
_COMMIT_DATE="20250307"
CLANDRO_PKG_VERSION="3.49.1.$_COMMIT_DATE"
CLANDRO_PKG_SRCURL="https://github.com/ericsink/cb/archive/${_COMMIT}.tar.gz"
CLANDRO_PKG_SHA256=4893433d7ff2e12e7ac35095a80710004f496fa4ec2527a3b188fad3d8a6f7e2
CLANDRO_PKG_EXCLUDED_ARCHES="arm"

clandro_step_make() {
	clandro_setup_dotnet
	local _target_cpu=""
	case "$CLANDRO_ARCH" in
		aarch64) _target_cpu="arm64" ;;
		arm) _target_cpu="armhf" ;;
		x86_64) _target_cpu="x64" ;;
		i686) _target_cpu="x86" ;;
		*) clandro_error_exit  "Unsupported arch: $CLANDRO_ARCH"
	esac

	echo "Building libe_sqlite3.so"
	( cd "${CLANDRO_PKG_SRCDIR}/bld" && dotnet run && "$CC" $CFLAGS @linux_e_sqlite3_"${_target_cpu}".gccargs -lm -ldl )
	clandro_dotnet_kill

	cp "${CLANDRO_PKG_SRCDIR}/bld/bin/e_sqlite3/linux/${_target_cpu}/libe_sqlite3.so" "$CLANDRO_PKG_BUILDDIR"
}

clandro_step_make_install() {
	install -Dm600 -t "${CLANDRO_PREFIX}/lib" "${CLANDRO_PKG_BUILDDIR}/libe_sqlite3.so"
}
