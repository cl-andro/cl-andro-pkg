CLANDRO_PKG_HOMEPAGE=https://mosh.org
CLANDRO_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.4.0
CLANDRO_PKG_REVISION=16
CLANDRO_PKG_SRCURL=https://github.com/mobile-shell/mosh/releases/download/mosh-${CLANDRO_PKG_VERSION}/mosh-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=872e4b134e5df29c8933dff12350785054d2fd2839b5ae6b5587b14db1465ddd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="abseil-cpp, libandroid-support, libc++, libprotobuf, ncurses, openssl, openssh"
CLANDRO_PKG_SUGGESTS="mosh-perl"

clandro_step_pre_configure() {
	clandro_setup_protobuf

	# Keep this the same version which abseil-cpp requires
	CXXFLAGS+=" -std=c++17"
	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}

clandro_step_post_make_install() {
	cd $CLANDRO_PREFIX/bin
	mv mosh mosh.pl
	$CXX $CXXFLAGS $LDFLAGS \
		-isystem $CLANDRO_PREFIX/include \
		-DPACKAGE_VERSION=\"$CLANDRO_PKG_VERSION\" \
		-std=c++11 -Wall -Wextra -Werror \
		$CLANDRO_PKG_BUILDER_DIR/mosh.cc -o mosh-bin
	cat <<-EOF > mosh
		#!$CLANDRO_PREFIX/bin/sh
		if [ -e "$CLANDRO_PREFIX/bin/mosh.pl" ]; then
			exec "$CLANDRO_PREFIX/bin/mosh.pl" "\$@"
		else
			exec "$CLANDRO_PREFIX/bin/mosh-bin" "\$@"
		fi
	EOF
	chmod 0700 mosh
}
