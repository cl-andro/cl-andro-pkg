CLANDRO_PKG_HOMEPAGE="https://github.com/Dadoum/Sideloader"
CLANDRO_PKG_DESCRIPTION="Open-source cross-platform iOS app sideloader. Alternative to Sideloadly, AltServer, SideServer, Cydia Impactor, iOS App Signer…"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT="35f486caa3cb01127508958f5e057d6c834d9cf7"
_COMMIT_DATE=2025.8.25
CLANDRO_PKG_VERSION="1.0~pre4.${_COMMIT_DATE}"
CLANDRO_PKG_DEPENDS="usbmuxd, libplist, libimobiledevice"
CLANDRO_PKG_BUILD_DEPENDS="ldc, ndk-sysroot, jq"
CLANDRO_PKG_SRCURL="https://github.com/Dadoum/Sideloader/archive/${_COMMIT}.zip"
CLANDRO_PKG_SHA256="9f3764b86ee596032d43302a4a4b900cea40b45c5f7f6e6ee58145e0cb65a4b7"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686" # ldc 1.30 contains broken a std.range.repeat that causes argparse to not compile.

clandro_step_post_get_source() {
	provision_git_url=$(jq -r '.versions.provision.repository' $CLANDRO_PKG_SRCDIR/frontends/cli/dub.selections.json | cut -c5-)
	provision_git_hash=$(jq -r '.versions.provision.version' $CLANDRO_PKG_SRCDIR/frontends/cli/dub.selections.json)
	plist_d_git_url=$(jq -r '.versions."plist-d".repository' $CLANDRO_PKG_SRCDIR/frontends/cli/dub.selections.json | cut -c5-)
	plist_d_git_hash=$(jq -r '.versions."plist-d".version' $CLANDRO_PKG_SRCDIR/frontends/cli/dub.selections.json)
}

clandro_step_configure() {
	clandro_setup_ldc
	dub clean --all-packages
	# Patch Provision
	git init Provision # The vendorize patch is case-sensitive.
	cd Provision
	git remote add origin $provision_git_url
	git fetch --depth 1 origin $provision_git_hash
	git checkout FETCH_HEAD
	patch -N -p1 -i $CLANDRO_PKG_BUILDER_DIR/Provision-Remove-glibc-backtrace-call.diff || true # It might already be applied
	cd ..
	# Patch plist-d
	git init libplist-d
	cd libplist-d
	git remote add origin $plist_d_git_url
	git fetch --depth 1 origin $plist_d_git_hash
	git checkout FETCH_HEAD
	patch -N -p1 -i $CLANDRO_PKG_BUILDER_DIR/plist-d-Add-filename-for-termux-libplist-2.0.so.diff || true # It might already be applied
	cd ..
}

clandro_step_make() {
	export DFLAGS="-preview=shortenedMethods" # Workaround for using an ancient ldc version
	dub build -b release-debug --arch ${CLANDRO_HOST_PLATFORM} :cli-frontend
}

clandro_step_make_install() {
	install -Dm 700 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/bin/sideloader
}

# Note for maintainers: In order to generate the "vendorize" patch, you should clone Provision and plist-d into the root directory of Sideloader and
# run `dub upgrade -s <dependency>` after applying your edits to the top level `dub.json` to update all the `dub.selections.json` which is what the compiler actually uses.
