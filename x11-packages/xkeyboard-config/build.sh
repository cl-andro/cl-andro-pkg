CLANDRO_PKG_HOMEPAGE=https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config
CLANDRO_PKG_DESCRIPTION="X keyboard configuration files"
CLANDRO_PKG_LICENSE="HPND, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.47"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/archive/xkeyboard-config-${CLANDRO_PKG_VERSION}/xkeyboard-config-xkeyboard-config-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b199d506aed1a03d00f11411091f6db8f136ef68f308d4747c76151e59cba874
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_DEPENDS="python"
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="StrEnum"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dcompat-rules=true
-Dxorg-rules-symlinks=true
"
