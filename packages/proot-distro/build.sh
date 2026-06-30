CLANDRO_PKG_HOMEPAGE=https://github.com/termux/proot-distro
CLANDRO_PKG_DESCRIPTION="Termux official utility for managing proot'ed Linux distributions"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.38.0"
CLANDRO_PKG_SRCURL=https://github.com/termux/proot-distro/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=10ddabe1df5f3b433e9add0d6c6460ece607ea39b3decb338ccde78c86c80aec
CLANDRO_PKG_DEPENDS="bash, bzip2, coreutils, curl, file, findutils, gzip, ncurses-utils, proot (>= 5.1.107-32), sed, tar, termux-tools, unzip, util-linux, xz-utils"
CLANDRO_PKG_SUGGESTS="bash-completion, termux-api"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

clandro_step_make_install() {
	env CLANDRO_APP_PACKAGE="$CLANDRO_APP_PACKAGE" \
		CLANDRO_PREFIX="$CLANDRO_PREFIX" \
		CLANDRO_ANDROID_HOME="$CLANDRO_ANDROID_HOME" \
		./install.sh

	# Patch: suppress id stderr for Android GIDs without /etc/group entries
	sed -i 's/id -Gn |/id -Gn 2>\/dev\/null |/' "${CLANDRO_PREFIX}/bin/proot-distro"

	# Patch: LD_PRELOAD restore must not return non-zero (kills install with set -e)
	sed -i '/# Restore LD_PRELOAD after proot.$/,+1 s/\[ -n "\$CLANDRO_LDPRELOAD" \] && export LD_PRELOAD="\$CLANDRO_LDPRELOAD"/[ -n "\$CLANDRO_LDPRELOAD" ] \&\& export LD_PRELOAD="\$CLANDRO_LDPRELOAD" || true/' "${CLANDRO_PREFIX}/bin/proot-distro"

	# Patch: use localedef --no-archive instead of dpkg-reconfigure locales
	# dpkg-reconfigure calls locale-gen which calls localedef without --no-archive,
	# which tries to create locale-archive via mmap -- blocked by Android kernel.
	sed -i 's/run_proot_cmd DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales/run_proot_cmd DEBIAN_FRONTEND=noninteractive localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8/' "${CLANDRO_PREFIX}/etc/proot-distro/debian.sh"
}
