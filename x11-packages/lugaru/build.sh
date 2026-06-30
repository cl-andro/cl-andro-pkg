CLANDRO_PKG_HOMEPAGE=https://osslugaru.gitlab.io
CLANDRO_PKG_DESCRIPTION="Lugaru HD, free and open source ninja rabbit fighting game"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@IntinteDAO"
CLANDRO_PKG_VERSION="1.2"
CLANDRO_PKG_SRCURL=https://gitlab.com/osslugaru/lugaru/-/archive/${CLANDRO_PKG_VERSION}/lugaru-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=b165ff8948f634fc788dc29b9269746340a290fc2101d843e270190a49c2ef00
CLANDRO_PKG_DEPENDS="glu, lugaru-data, openal-soft, sdl2 | sdl2-compat"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DSYSTEM_INSTALL=ON
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	export LDFLAGS+=" -Wl,--no-as-needed,-lOpenSLES,--as-needed"
}
