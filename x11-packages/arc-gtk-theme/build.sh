CLANDRO_PKG_HOMEPAGE=https://github.com/jnsh/arc-theme/
CLANDRO_PKG_DESCRIPTION="A flat theme with transparent elements"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=20221218
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/jnsh/arc-theme/releases/download/${CLANDRO_PKG_VERSION}/arc-theme-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=264570cc90a13b88d181334fb325f99a6ddc2a45392aa9ed7dba312aea042bb0
CLANDRO_PKG_BUILD_DEPENDS="glib, sassc"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgnome_shell_gresource=true
-Dcinnamon_version=5.6
-Dgnome_shell_version=43
"
