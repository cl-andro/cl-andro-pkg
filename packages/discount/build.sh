CLANDRO_PKG_HOMEPAGE="https://www.pell.portland.or.us/~orc/Code/discount/"
CLANDRO_PKG_DESCRIPTION="Markdown implementation written in C"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="COPYRIGHT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.1.2"
CLANDRO_PKG_SRCURL="https://github.com/Orc/discount/archive/v${CLANDRO_PKG_VERSION}/discount-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=4ea6cc8782c6508b3051c469ed7a1b6ca20b023c2a0c26ccd9c83bc7e61dfc16
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DBUILD_SHARED_LIBS=ON
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja

	cmake "$CLANDRO_PKG_SRCDIR/cmake" -GNinja $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_pre_configure() {
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR:$PATH"
	CLANDRO_PKG_SRCDIR+="/cmake"
}

clandro_step_post_configure() {
	CLANDRO_PKG_SRCDIR+=/..
}
