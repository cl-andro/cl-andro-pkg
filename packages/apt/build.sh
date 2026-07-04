CLANDRO_PKG_HOMEPAGE=https://packages.debian.org/apt
CLANDRO_PKG_DESCRIPTION="Front-end for the dpkg package manager"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.1"
CLANDRO_PKG_REVISION=2
# old tarball are removed in https://deb.debian.org/debian/pool/main/a/apt/apt_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SRCURL=https://salsa.debian.org/apt-team/apt/-/archive/${CLANDRO_PKG_VERSION}/apt-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=87ca18392c10822a133b738118505f7d04e0b31ba1122bf5d32911311cb2dc7e
# apt-key requires utilities from coreutils, findutils, gpgv, grep, sed.
CLANDRO_PKG_DEPENDS="coreutils, dpkg, findutils, grep, libandroid-glob, libbz2, libc++, libgnutls, libiconv, libgcrypt, liblz4, liblzma, sed, clandro-keyring, clandro-licenses, xxhash, zlib, zstd"
CLANDRO_PKG_BUILD_DEPENDS="docbook-xsl,libdb"
CLANDRO_PKG_CONFLICTS="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
CLANDRO_PKG_REPLACES="apt-transport-https, libapt-pkg, unstable-repo, game-repo, science-repo"
CLANDRO_PKG_PROVIDES="unstable-repo, game-repo, science-repo"
CLANDRO_PKG_SUGGESTS="gnupg"
CLANDRO_PKG_ESSENTIAL=true

CLANDRO_PKG_CONFFILES="
etc/apt/sources.list
"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DPERL_EXECUTABLE=$(command -v perl)
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$CLANDRO_PREFIX
-DCACHE_DIR=${CLANDRO_CACHE_DIR}/apt
-DCOMMON_ARCH=$CLANDRO_ARCH
-DDPKG_DATADIR=$CLANDRO_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
-DWITH_DOC_MANPAGES=ON
"

# ubuntu uses instead $PREFIX/lib instead of $PREFIX/libexec to
# "Work around bug in GNUInstallDirs" (from apt 1.4.8 CMakeLists.txt).
# Archlinux uses $PREFIX/libexec though, so let's force libexec->lib to
# get same build result on ubuntu and archlinux.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="-DCMAKE_INSTALL_LIBEXECDIR=lib"

CLANDRO_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/methods/cdrom
lib/apt/methods/mirror*
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
share/man/man1/apt-extracttemplates.1
share/man/man1/apt-sortpkgs.1
share/man/man1/apt-transport-mirror.1
share/man/man8/apt-cdrom.8
"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	# Fix i686 builds.
	CXXFLAGS+=" -Wno-c++11-narrowing"
	# Fix glob() on Android 7.
	LDFLAGS+=" -Wl,--no-as-needed -landroid-glob"

	# for manpage build
	local docbook_xsl_version=$(. $CLANDRO_SCRIPTDIR/packages/docbook-xsl/build.sh; echo $CLANDRO_PKG_VERSION)
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DDOCBOOK_XSL=$CLANDRO_PREFIX/share/xml/docbook/xsl-stylesheets-$docbook_xsl_version-nons"
}

clandro_step_post_make_install() {
	{
		echo "# The main cl-andro repository"
		echo "deb [signed-by=/data/data/com.zk.clandro/files/usr/etc/apt/trusted.gpg.d/cl-andro.gpg] https://cl-andro.github.io/cl-andro-packages/ stable main"
	} > $CLANDRO_PREFIX/etc/apt/sources.list

	{
		echo 'Acquire::https::CACertificate "/data/data/com.zk.clandro/files/usr/etc/tls/cert.pem";'
		echo 'Dir::Bin::gpgv "/data/data/com.zk.clandro/files/usr/bin/gpgv";'
	} > $CLANDRO_PREFIX/etc/apt/apt.conf


	# apt-transport-tor
	ln -sfr $CLANDRO_PREFIX/lib/apt/methods/http $CLANDRO_PREFIX/lib/apt/methods/tor
	ln -sfr $CLANDRO_PREFIX/lib/apt/methods/http $CLANDRO_PREFIX/lib/apt/methods/tor+http
	ln -sfr $CLANDRO_PREFIX/lib/apt/methods/https $CLANDRO_PREFIX/lib/apt/methods/tor+https
	# Workaround for "empty" subpackage:
	local dir=$CLANDRO_PREFIX/share/apt-transport-tor
	mkdir -p $dir
	touch $dir/.placeholder
}
