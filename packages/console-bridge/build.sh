CLANDRO_PKG_HOMEPAGE="https://github.com/ros/console_bridge"
CLANDRO_PKG_DESCRIPTION="A ROS-independent package for logging that seamlessly pipes into rosconsole/rosout for ROS-dependent packages"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Pooya Moradi <pvonmoradi@gmail.com>"
CLANDRO_PKG_VERSION="1.0.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/ros/console_bridge/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=303a619c01a9e14a3c82eb9762b8a428ef5311a6d46353872ab9a904358be4a4
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"
