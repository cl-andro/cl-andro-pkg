CLANDRO_PKG_HOMEPAGE=https://clandro.dev/
CLANDRO_PKG_DESCRIPTION="Basic system tools for Termux"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.46.0+really1.45.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/cl-andro/clandro-tools/archive/refs/tags/v1.45.0.tar.gz
CLANDRO_PKG_SHA256=93d8e8169974f27f8519ef1e6df3c4bafed5ab6ff0af91b21bf5fbd03782e408
CLANDRO_PKG_ESSENTIAL=true
#CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BREAKS="clandro-keyring (<< 1.9)"
CLANDRO_PKG_CONFLICTS="procps (<< 3.3.15-2)"
CLANDRO_PKG_SUGGESTS="clandro-api"

# Some of these packages are not dependencies and used only to ensure
# that core packages are installed after upgrading (we removed busybox
# from essentials).
CLANDRO_PKG_DEPENDS="bzip2, coreutils, curl, dash, diffutils, findutils, gawk, grep, gzip, less, procps, psmisc, sed, tar, clandro-am (>= 0.8.0), clandro-am-socket (>= 1.5.0), clandro-core, clandro-exec, util-linux, xz-utils, dialog"

# Optional packages that are distributed as part of bootstrap archives.
CLANDRO_PKG_RECOMMENDS="ed, dos2unix, inetutils, net-tools, patch, unzip"

clandro_step_post_get_source() {
	# Patch .in template files before autoreconf processes them
	#
	# init-clandro-properties.sh.in uses @CLANDRO_HOME@ placeholder
	local props="$CLANDRO_PKG_SRCDIR/init-clandro-properties.sh.in"
	if [ -f "$props" ]; then
		sed -i \
			-e 's|@CLANDRO_HOME@/\.config/clandro/clandro\.properties|@CLANDRO_HOME@/.config/cl-andro/clandro.properties|g' \
			-e 's|@CLANDRO_HOME@/\.clandro/clandro\.properties|@CLANDRO_HOME@/.cl-andro/clandro.properties|g' \
			-e 's|@CLANDRO_PREFIX@/share/examples/clandro/clandro\.properties @CLANDRO_HOME@/\.clandro/|@CLANDRO_PREFIX@/share/examples/clandro/clandro.properties @CLANDRO_HOME@/.cl-andro/clandro.properties|g' \
			-e 's|@CLANDRO_HOME@/\.clandro|@CLANDRO_HOME@/.cl-andro|g' \
			"$props"
	fi

	# Patch scripts/*.in: simple ~/.clandro and $HOME/.clandro -> .cl-andro
	while IFS= read -r f; do
		sed -i \
			-e 's|~/\?\.clandro|~/.cl-andro|g' \
			-e 's|\$HOME/\.clandro|\$HOME/.cl-andro|g' \
			-e 's|clandro\.properties|clandro.properties|g' \
			"$f"
	done < <(grep -rl '\.clandro' "$CLANDRO_PKG_SRCDIR/scripts/" 2>/dev/null || true)
}

clandro_step_pre_configure() {
	autoreconf -vfi
}

clandro_step_post_make_install() {
	CLANDRO_PKG_CONFFILES="$(cat "$CLANDRO_PKG_BUILDDIR/conffiles")"

	# Custom welcome message for cl-andro
	echo "Welcome to cl-andro (Cluster Family)!" > $CLANDRO_PREFIX/etc/motd
	echo "Use the 'apt' command to manage packages." >> $CLANDRO_PREFIX/etc/motd

	cp $CLANDRO_PREFIX/etc/motd $CLANDRO_PREFIX/etc/motd-playstore

	cat <<- EOF > $CLANDRO_PREFIX/etc/motd.sh
	#!/data/data/com.zk.clandro/files/usr/bin/bash
	echo "Welcome to cl-andro (Cluster Family)!"
	echo "Use the 'apt' command to manage packages."
	EOF
	chmod +x $CLANDRO_PREFIX/etc/motd.sh
}

clandro_step_create_debscripts() {
	cat <<- EOF > ./preinst
	$(cat "$CLANDRO_PKG_BUILDDIR/preinst")
	EOF
}
# Forge: Retrigger build with fixed run-docker.sh
