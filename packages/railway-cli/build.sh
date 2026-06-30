CLANDRO_PKG_HOMEPAGE=https://railway.app
CLANDRO_PKG_DESCRIPTION="This is the command line interface for Railway"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.57.1"
CLANDRO_PKG_SRCURL="https://github.com/railwayapp/cli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=be3011ac0c9f0da24f1fa8c6fe0e5541695fbde97835d5e4dabef9c9bbfb14cd
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo vendor
	find ./vendor \
		-mindepth 1 -maxdepth 1 -type d \
		! -wholename ./vendor/arboard \
		! -wholename ./vendor/x11rb-protocol \
		-exec rm -rf '{}' \;

	find vendor/{arboard,x11rb-protocol} -type f -print0 | \
		xargs -0 sed -i \
		-e 's|android|disabling_this_because_it_is_for_building_an_apk|g' \
		-e "s|/tmp|$CLANDRO_PREFIX/tmp|g"

	echo "" >> Cargo.toml
	echo '[patch.crates-io]' >> Cargo.toml
	echo "arboard = { path = \"./vendor/arboard\" }" >> Cargo.toml
	echo "x11rb-protocol = { path = \"./vendor/x11rb-protocol\" }" >> Cargo.toml
}
