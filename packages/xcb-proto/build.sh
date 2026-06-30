# X11 package
CLANDRO_PKG_HOMEPAGE=https://xcb.freedesktop.org/
CLANDRO_PKG_DESCRIPTION="XML-XCB protocol descriptions"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.17.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=2c1bacd2110f4799f74de6ebb714b94cf6f80fb112316b1219480fd22562148c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_CONFLICTS="xcbproto"
CLANDRO_PKG_REPLACES="xcbproto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PYTHON=/usr/bin/python3
am_cv_python_pythondir=$CLANDRO_PYTHON_HOME/site-packages
"

clandro_step_post_make_install() {
	# We are using Ubuntu's host python for installing the package which may be of
	# different major version. Python bytecode isn't compatible across versions.
	# So get rid of it
	rm -r "$CLANDRO_PREFIX/lib/python3.13/site-packages/xcbgen/__pycache__/"
}
