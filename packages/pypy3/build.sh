CLANDRO_PKG_HOMEPAGE=https://pypy.org
CLANDRO_PKG_DESCRIPTION="A fast, compliant alternative implementation of Python 3"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@licy183"
_MAJOR_VERSION=3.11
CLANDRO_PKG_VERSION=7.3.22
CLANDRO_PKG_SRCURL=https://downloads.python.org/pypy/pypy$_MAJOR_VERSION-v$CLANDRO_PKG_VERSION-src.tar.bz2
CLANDRO_PKG_SHA256=9f885a47a232b957f9b5cc4307264af229570ddea62a9c175351afa3a6321820
CLANDRO_PKG_DEPENDS="gdbm, libandroid-posix-semaphore, libandroid-support, libbz2, libcrypt, libexpat, libffi, liblzma, libsqlite, ncurses, ncurses-ui-libs, openssl, zlib"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs, coreutils, clang, make, pkg-config, python2, tk, xorgproto"
CLANDRO_PKG_RECOMMENDS="clang, make, pkg-config"
CLANDRO_PKG_SUGGESTS="pypy3-tkinter"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

clandro_step_post_get_source() {
	local sqlite_version=$(. $CLANDRO_SCRIPTDIR/packages/libsqlite/build.sh; echo $CLANDRO_PKG_VERSION)
	local sqlite_version_X=$(cut -d"." -f1 <<< "$sqlite_version")
	local sqlite_version_Y=$(cut -d"." -f2 <<< "$sqlite_version")
	local sqlite_version_Z=$(cut -d"." -f3 <<< "$sqlite_version")
	local SQLITE_VERSION_NUMBER=$(bc <<< "($sqlite_version_X) * 1000000 + ($sqlite_version_Y) * 1000 + ($sqlite_version_Z)")
	local p="$CLANDRO_PKG_BUILDER_DIR/9997-do-not-cffi-dlopen-when-compiling-sqlite3.diff"
	echo "Applying $(basename "${p}")"
	sed \
		's|@SQLITE_HAS_LOAD_EXTENSION@|True|g
		s|@SQLITE_HAS_BACKUP@|True|g
		s|@SQLITE_VERSION_NUMBER@|'"${SQLITE_VERSION_NUMBER}"'|g' \
		"${p}" | patch --silent -p1

	p="$CLANDRO_PKG_BUILDER_DIR/9998-link-against-pypy3-on-testcapi.diff"
	echo "Applying $(basename "${p}")"
	sed 's|@CLANDRO_PYPY_MAJOR_VERSION@|'"${_MAJOR_VERSION}"'|g' "${p}" \
		| patch --silent -p1

	p="$CLANDRO_PKG_BUILDER_DIR/9999-add-ANDROID_API_LEVEL-for-sysconfigdata.diff"
	echo "Applying $(basename "${p}")"
	sed 's|@CLANDRO_PKG_API_LEVEL@|'"${CLANDRO_PKG_API_LEVEL}"'|g' "${p}" \
		| patch --silent -p1

	sed -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@CLANDRO_PKG_API_LEVEL@|${CLANDRO_PKG_API_LEVEL}|g" \
		"$CLANDRO_PKG_BUILDER_DIR"/termux.py.in > \
		"$CLANDRO_PKG_SRCDIR"/rpython/translator/platform/termux.py
}

__setup_proot() {
	mkdir -p "$CLANDRO_PKG_CACHEDIR"/proot-bin
	clandro_download \
		https://github.com/proot-me/proot/releases/download/v5.3.0/proot-v5.3.0-x86_64-static \
		"$CLANDRO_PKG_CACHEDIR"/proot-bin/proot \
		d1eb20cb201e6df08d707023efb000623ff7c10d6574839d7bb42d0adba6b4da
	chmod +x "$CLANDRO_PKG_CACHEDIR"/proot-bin/proot
	mkdir -p "$CLANDRO_PKG_TMPDIR"/proot-tmp-dir
	export PATH="$CLANDRO_PKG_CACHEDIR/proot-bin:$PATH"
}

__setup_qemu_static_binaries() {
	mkdir -p "$CLANDRO_PKG_CACHEDIR"/qemu-static-bin
	clandro_download \
		https://github.com/multiarch/qemu-user-static/releases/download/v7.2.0-1/qemu-aarch64-static \
		"$CLANDRO_PKG_CACHEDIR"/qemu-static-bin/qemu-aarch64-static \
		dce64b2dc6b005485c7aa735a7ea39cb0006bf7e5badc28b324b2cd0c73d883f
	clandro_download \
		https://github.com/multiarch/qemu-user-static/releases/download/v7.2.0-1/qemu-arm-static \
		"$CLANDRO_PKG_CACHEDIR"/qemu-static-bin/qemu-arm-static \
		9f07762a3cd0f8a199cb5471a92402a4765f8e2fcb7fe91a87ee75da9616a806
	chmod +x "$CLANDRO_PKG_CACHEDIR"/qemu-static-bin/qemu-aarch64-static
	chmod +x "$CLANDRO_PKG_CACHEDIR"/qemu-static-bin/qemu-arm-static
	export PATH="$CLANDRO_PKG_CACHEDIR/qemu-static-bin:$PATH"
}

__setup_docker_utils() {
	mkdir -p "$CLANDRO_PKG_CACHEDIR"/docker-utils
	clandro_download \
		https://raw.githubusercontent.com/NotGlop/docker-drag/5413165a2453aa0bc275d7dc14aeb64e814d5cc0/docker_pull.py \
		"$CLANDRO_PKG_CACHEDIR"/docker-utils/docker_pull.py \
		04e52b70c862884e75874b2fd229083fdf09a4bac35fc16fd7a0874ba20bd075
	clandro_download \
		https://raw.githubusercontent.com/larsks/undocker/649f3fdeb0a9cf8aa794d90d6cc6a7c7698a25e6/undocker.py \
		"$CLANDRO_PKG_CACHEDIR"/docker-utils/undocker.py \
		32bc122c53153abeb27491e6d45122eb8cef4f047522835bedf9b4b87877a907
}

__setup_termux_docker_rootfs() {
	__setup_docker_utils

	# Pick up host platform arch
	local __pypy3_host_arch=""
	if [ "$CLANDRO_ARCH_BITS" = "32" ]; then
		__pypy3_host_arch="i686"
	else
		__pypy3_host_arch="x86_64"
	fi

	# Get host platform rootfs tar if needed
	if [ ! -f "$CLANDRO_PKG_CACHEDIR/clandro_clandro-docker_$__pypy3_host_arch.tar" ]; then
		(
			cd "$CLANDRO_PKG_CACHEDIR"
			python docker-utils/docker_pull.py termux/clandro-docker:$__pypy3_host_arch
			mv clandro_clandro-docker.tar clandro_clandro-docker_$__pypy3_host_arch.tar
		)
	fi

	# Download busybox, update-static-dns and static-dns-hosts.txt from older clandro-docker commit
	mkdir -p "$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils
	clandro_download \
		https://github.com/termux/clandro-docker/raw/98af62205f4da832b71bb4de09cb8d6b17ceeaca/static-dns-hosts.txt \
		"$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/static-dns-hosts.txt \
		f5e28c8d37dc69e4876372cc05dcfd07aadc8499f5fa05bb6af1cfbff7cd656a
	clandro_download \
		https://github.com/termux/clandro-docker/raw/98af62205f4da832b71bb4de09cb8d6b17ceeaca/system/x86/bin/update-static-dns \
		"$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/update-static-dns \
		14b6ba13506dd90b691e5dbb84bf79ca155837dd43eb05c0e68fbe991c05ee5e
	clandro_download \
		https://github.com/termux/clandro-docker/raw/98af62205f4da832b71bb4de09cb8d6b17ceeaca/system/x86/bin/busybox \
		"$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/busybox \
		6c63a8623659aff24843d9b0720fa4aa216d44a5d60f29979a4073f3f80ce69c

	# Extract host platform rootfs tar
	__pypy3_host_rootfs="$CLANDRO_PKG_CACHEDIR/host-termux-rootfs-$__pypy3_host_arch"
	if [ ! -d "$__pypy3_host_rootfs" ]; then
		rm -rf "$__pypy3_host_rootfs".tmp
		mkdir -p "$__pypy3_host_rootfs".tmp
		cat "$CLANDRO_PKG_CACHEDIR"/clandro_clandro-docker_$__pypy3_host_arch.tar | \
			python "$CLANDRO_PKG_CACHEDIR"/docker-utils/undocker.py -o "$__pypy3_host_rootfs".tmp
		mkdir -p "$__pypy3_host_rootfs".tmp/"$CLANDRO_PREFIX"/bin
		mkdir -p "$__pypy3_host_rootfs".tmp/"$CLANDRO_ANDROID_HOME"
		cp "$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/static-dns-hosts.txt \
			"$__pypy3_host_rootfs".tmp/system/etc/
		cp "$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/update-static-dns \
			"$__pypy3_host_rootfs".tmp/"$CLANDRO_PREFIX"/bin/
		cp "$CLANDRO_PKG_CACHEDIR"/clandro-docker-utils/busybox \
			"$__pypy3_host_rootfs".tmp/system/bin/
		cp "$CLANDRO_PKG_CACHEDIR"/proot-bin/proot \
			"$__pypy3_host_rootfs".tmp/"$CLANDRO_PREFIX"/bin/
		chmod +x "$__pypy3_host_rootfs".tmp/"$CLANDRO_PREFIX"/bin/update-static-dns
		chmod +x "$__pypy3_host_rootfs".tmp/system/bin/busybox
		rm -f "$__pypy3_host_rootfs".tmp/bin
		rm -f "$__pypy3_host_rootfs".tmp/usr
		rm -f "$__pypy3_host_rootfs".tmp/tmp
		mv "$__pypy3_host_rootfs".tmp "$__pypy3_host_rootfs"
	fi
}

__setup_termux_envs() {
	__pypy3_termux_envs="
ANDROID_DATA=/data
ANDROID_ROOT=/system
HOME=$CLANDRO_ANDROID_HOME
LANG=en_US.UTF-8
PATH=$CLANDRO_PREFIX/bin
PREFIX=$CLANDRO_PREFIX
TMPDIR=$CLANDRO_PREFIX/tmp
TERM=$TERM
TZ=UTC"

	__pypy3_run_on_host="
env -i
PROOT_NO_SECCOMP=1
PROOT_TMP_DIR=/tmp
$__pypy3_termux_envs
$CLANDRO_PKG_CACHEDIR/proot-bin/proot
-b /proc -b /dev -b /sys
-b $HOME
-b /tmp
-b /data/:/target-termux-rootfs/data/
-b /system/:/target-termux-rootfs/system/
-w $CLANDRO_PKG_TMPDIR
-r $__pypy3_host_rootfs/
"

	__pypy3_run_on_target_from_builder="
env -i
PROOT_NO_SECCOMP=1
PROOT_TMP_DIR=/tmp
$__pypy3_termux_envs
$CLANDRO_PKG_CACHEDIR/proot-bin/proot
-b /data/:/target-termux-rootfs/data/
-b /system/:/target-termux-rootfs/system/
-w $CLANDRO_PKG_TMPDIR
-R /
/usr/bin/env -i
PROOT_NO_SECCOMP=1
PROOT_TMP_DIR=/tmp
$__pypy3_termux_envs
$CLANDRO_PKG_CACHEDIR/proot-bin/proot
-b /proc -b /dev -b /sys
-b /bin/bash
-b /lib -b /lib64
-b $HOME
-b /tmp
-w $CLANDRO_PKG_TMPDIR
-r /target-termux-rootfs/
"

	__pypy3_run_on_target_from_host="
env -i
PROOT_NO_SECCOMP=1
PROOT_TMP_DIR=/tmp
$__pypy3_termux_envs
$CLANDRO_PKG_CACHEDIR/proot-bin/proot
-b /proc -b /dev -b /sys
-b $HOME
-b /tmp
-b $CLANDRO_ANDROID_HOME:$CLANDRO_ANDROID_HOME
-w $CLANDRO_PKG_TMPDIR
-r /target-termux-rootfs/
"

	# Set qemu-user-static if needed
	case "$CLANDRO_ARCH" in
		"aarch64" |  "arm")
			__pypy3_run_on_target_from_host+=" -q $CLANDRO_PKG_CACHEDIR/qemu-static-bin/qemu-$CLANDRO_ARCH-static"
			__pypy3_run_on_target_from_builder+=" -q $CLANDRO_PKG_CACHEDIR/qemu-static-bin/qemu-$CLANDRO_ARCH-static"
			;;
		*)
			;;
	esac
}

__run_on_host_docker_rootfs() {
	$__pypy3_run_on_host "$@"
}

clandro_step_configure() {
	__setup_proot
	__setup_qemu_static_binaries
	__setup_docker_utils
	__setup_termux_docker_rootfs
	__setup_termux_envs

	# Install deps on host termux rootfs if needed
	__run_on_host_docker_rootfs update-static-dns
	__run_on_host_docker_rootfs apt update
	__run_on_host_docker_rootfs apt upgrade -yq -o Dpkg::Options::=--force-confnew
	__run_on_host_docker_rootfs apt update
	__run_on_host_docker_rootfs apt install binutils clang ndk-sysroot ndk-multilib python2 make -y
	__run_on_host_docker_rootfs python2 -m pip install cffi pycparser

	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD=1"
	# error: incompatible function pointer types passing 'Signed (*)(void *, const char *, XML_Encoding *)' (aka 'long (*)(void *, const char *, XML_Encoding *)') to parameter of type 'XML_UnknownEncodingHandler' (aka 'int (*)(void *, const char *, XML_Encoding *)') [-Wincompatible-function-pointer-types]
	CFLAGS+=" -Wno-incompatible-function-pointer-types"
}

clandro_step_make() {
	mkdir -p "$CLANDRO_PKG_SRCDIR"/usession-dir

	__run_on_host_docker_rootfs uname -a
	__run_on_host_docker_rootfs $__pypy3_run_on_target_from_host uname -a

	# (Cross) Translation
	__run_on_host_docker_rootfs \
		env \
		-C "$CLANDRO_PKG_SRCDIR"/pypy/goal \
		PYPY_USESSION_DIR="$CLANDRO_PKG_SRCDIR/usession-dir" \
		PROOT_TARGET="$__pypy3_run_on_target_from_host" \
		TARGET_CFLAGS="$CFLAGS $CPPFLAGS" \
		TARGET_LDFLAGS="$LDFLAGS" \
		python2 -u ../../rpython/bin/rpython \
				--platform=termux-"$CLANDRO_ARCH" \
				--source --no-compile -Ojit \
				targetpypystandalone.py

	# Build
	cd "$CLANDRO_PKG_SRCDIR"/usession-dir
	cd "$(ls -C | awk '{print $1}')"/testing_1
	local srcdir="$(pwd)"
	__run_on_host_docker_rootfs \
		env -C "$srcdir" make clean
	__run_on_host_docker_rootfs \
		env -C "$srcdir" make -j$CLANDRO_PKG_MAKE_PROCESSES

	# Copy the built files
	cp ./pypy$_MAJOR_VERSION-c "$CLANDRO_PKG_SRCDIR"/pypy/goal/pypy$_MAJOR_VERSION-c
	cp ./libpypy$_MAJOR_VERSION-c.so "$CLANDRO_PKG_SRCDIR"/pypy/goal/libpypy$_MAJOR_VERSION-c.so
	cp ./libpypy$_MAJOR_VERSION-c.so "$CLANDRO_PREFIX"/lib/libpypy$_MAJOR_VERSION-c.so

	echo $__pypy3_run_on_host
	echo $__pypy3_run_on_target_from_host
	echo $__pypy3_run_on_target_from_builder

	# Dummy cc and strip
	rm -rf "$CLANDRO_PKG_TMPDIR"/dummy-bin
	mkdir -p "$CLANDRO_PKG_TMPDIR"/dummy-bin
	cp "$CLANDRO_PKG_BUILDER_DIR"/cc.sh "$CLANDRO_PKG_TMPDIR"/dummy-bin/cc
	chmod +x "$CLANDRO_PKG_TMPDIR"/dummy-bin/cc
	ln -sf $(command -v llvm-strip) "$CLANDRO_PKG_TMPDIR"/dummy-bin/strip

	# Set host-rootfs if needed
	local HOST_ROOTFS=""
	case "$CLANDRO_ARCH" in
		"aarch64" |  "arm")
			HOST_ROOTFS="/host-rootfs"
			;;
		*)
			;;
	esac

	# Build cffi imports (Cross exec)
	$__pypy3_run_on_target_from_builder \
		env -i \
		PATH="$CLANDRO_PKG_TMPDIR/dummy-bin:$CLANDRO_PREFIX/bin" \
		HOST_ROOTFS="$HOST_ROOTFS" \
		CLANDRO_STANDALONE_TOOLCHAIN="$CLANDRO_STANDALONE_TOOLCHAIN" \
		CC="$CLANDRO_PKG_TMPDIR/dummy-bin/cc" \
		LDSHARED="$CLANDRO_PKG_TMPDIR/dummy-bin/cc -pthread -shared" \
		CCCLANDRO_HOST_PLATFORM="$CCCLANDRO_HOST_PLATFORM" \
		CFLAGS="$CFLAGS $CPPFLAGS" \
		LDFLAGS="$LDFLAGS" \
		"$CLANDRO_PKG_SRCDIR"/pypy/goal/pypy$_MAJOR_VERSION-c \
			$CLANDRO_PKG_SRCDIR/pypy/tool/release/package.py \
			--archive-name=pypy$_MAJOR_VERSION-v$CLANDRO_PKG_VERSION \
			--targetdir=$CLANDRO_PKG_SRCDIR \
			--no-embedded-dependencies \
			--no-keep-debug

	rm -f "$CLANDRO_PREFIX"/lib/libpypy$_MAJOR_VERSION-c.so
}

clandro_step_make_install() {
	rm -rf $CLANDRO_PREFIX/opt/pypy3
	unzip -d $CLANDRO_PREFIX/opt/ pypy$_MAJOR_VERSION-v$CLANDRO_PKG_VERSION.zip
	mv $CLANDRO_PREFIX/opt/pypy$_MAJOR_VERSION-v$CLANDRO_PKG_VERSION $CLANDRO_PREFIX/opt/pypy3
	ln -sfr $CLANDRO_PREFIX/opt/pypy3/bin/pypy3 $CLANDRO_PREFIX/bin/
	ln -sfr $CLANDRO_PREFIX/opt/pypy3/bin/libpypy3-c.so $CLANDRO_PREFIX/lib/
}

clandro_step_create_debscripts() {
	# postinst script to clean up runtime-generated files of previous pypy3 versions that
	# do not match the current $_MAJOR_VERSION
	# (this one needs to have bash in the shebang, not sh, because of the use of a
	# wildcard feature that does not work if the shebang is sh)
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	echo "Deleting files from other versions of $CLANDRO_PKG_NAME..."
	rm -Rf $CLANDRO_PREFIX/opt/$CLANDRO_PKG_NAME/lib/pypy*[^$_MAJOR_VERSION]
	exit 0
	POSTINST_EOF

	# Pre-rm script to cleanup runtime-generated files.
	cat <<- PRERM_EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh

	if [ "$CLANDRO_PACKAGE_FORMAT" = "debian" ] && [ "\$1" != "remove" ]; then
	    exit 0
	fi

	echo "Deleting files from site-packages..."
	rm -Rf $CLANDRO_PREFIX/opt/pypy3/lib/pypy$_MAJOR_VERSION/site-packages/*

	echo "Deleting *.pyc..."
	find $CLANDRO_PREFIX/opt/pypy3/lib/ | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

	exit 0
	PRERM_EOF

	chmod 0755 postinst prerm
}
