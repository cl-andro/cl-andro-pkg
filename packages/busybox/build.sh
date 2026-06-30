CLANDRO_PKG_HOMEPAGE=https://busybox.net/
CLANDRO_PKG_DESCRIPTION="Tiny versions of many common UNIX utilities into a single small executable"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.37.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://busybox.net/downloads/busybox-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=3311dff32e746499f4df0d5df04d7eb396382d7e108bb9250e7b519b837043a4
CLANDRO_PKG_DEPENDS="libandroid-selinux"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_SERVICE_SCRIPT=(
	"telnetd" 'exec busybox telnetd -F'
	"ftpd" "exec busybox tcpsvd -vE 0.0.0.0 8021 busybox ftpd -w $CLANDRO_ANDROID_HOME"
	"busybox-httpd" "exec busybox httpd -f -p 0.0.0.0:8080 -h $CLANDRO_PREFIX/srv/www/ 2>&1"
)

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi
}

clandro_step_configure() {
	# Prevent spamming logs with useless warnings to make them more readable.
	CFLAGS+=" -Wno-ignored-optimization-argument -Wno-unused-command-line-argument"

	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		-e "s|@CLANDRO_SYSROOT@|$CLANDRO_STANDALONE_TOOLCHAIN/sysroot|g" \
		-e "s|@CLANDRO_HOST_PLATFORM@|${CLANDRO_HOST_PLATFORM}|g" \
		-e "s|@CLANDRO_CFLAGS@|$CFLAGS|g" \
		-e "s|@CLANDRO_LDFLAGS@|$LDFLAGS|g" \
		-e "s|@CLANDRO_LDLIBS@|log|g" \
		"$CLANDRO_PKG_BUILDER_DIR/busybox.config" > .config
	unset CFLAGS LDFLAGS
	make oldconfig
}

clandro_step_make_install() {
	# Using unstripped variant. The post-massage step will strip binaries anyway.
	install -Dm700 "./0_lib/busybox_unstripped" "$CLANDRO_PREFIX/bin/busybox"
	install -Dm700 "./0_lib/libbusybox.so.${CLANDRO_PKG_VERSION}_unstripped" "$CLANDRO_PREFIX/lib/libbusybox.so.${CLANDRO_PKG_VERSION}"
	ln -sfr "$CLANDRO_PREFIX/lib/libbusybox.so.${CLANDRO_PKG_VERSION}" "$CLANDRO_PREFIX/lib/libbusybox.so"

	# Install busybox man page.
	install -Dm600 -t "$CLANDRO_PREFIX/share/man/man1" "$CLANDRO_PKG_SRCDIR/docs/busybox.1"

	# Symlink ash -> busybox
	ln -sfr "$CLANDRO_PREFIX"/bin/{busybox,ash}
	ln -sfr "$CLANDRO_PREFIX"/share/man/man1/{busybox,ash}.1

	mkdir -p "$CLANDRO_PREFIX/libexec/busybox"

	local applet
	for applet in 'less' 'nc' 'vi'; do
		{ # Set up a wrapper script to be called by `update-alternatives`
			echo "#!$CLANDRO_PREFIX/bin/sh"
			echo "exec busybox $applet \"\$@\""
		} > "$CLANDRO_PREFIX/libexec/busybox/$applet"
		chmod 700 "$CLANDRO_PREFIX/libexec/busybox/$applet"
	done
}
