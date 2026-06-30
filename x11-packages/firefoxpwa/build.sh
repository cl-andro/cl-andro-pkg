CLANDRO_PKG_HOMEPAGE=https://pwasforfirefox.filips.si/
CLANDRO_PKG_DESCRIPTION="A tool to install, manage and use Progressive Web Apps (PWAs) in Mozilla Firefox (native component)"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.18.2"
CLANDRO_PKG_SRCURL="https://github.com/filips123/PWAsForFirefox/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=a6956631ba62442d108cddfd8139d69d39f47004e8d36390a042ab8580d08021
CLANDRO_PKG_DEPENDS="firefox"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_make() {
	cd native
	clandro_setup_rust
	# Set the correct version in source files
	sed -i "s/version = \"0.0.0\"/version = \"${CLANDRO_PKG_VERSION}\"/g" Cargo.toml
	sed -i "s/DISTRIBUTION_VERSION = '0.0.0'/DISTRIBUTION_VERSION = '${CLANDRO_PKG_VERSION}'/g" userchrome/profile/chrome/pwa/chrome.sys.mjs

	local release_arg="--release"
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		release_arg=""
	fi

	cargo build $release_arg --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME"
}

clandro_step_make_install() {
	cd native

	local build_dir="target/${CARGO_TARGET_NAME}/release"
	if [[ "$CLANDRO_DEBUG_BUILD" == "true" ]]; then
		build_dir="target/${CARGO_TARGET_NAME}/debug"
	fi

	install -Dm755 -t "$CLANDRO_PREFIX/bin" "$build_dir/firefoxpwa"
	install -Dm755 -t "$CLANDRO_PREFIX/libexec" "$build_dir/firefoxpwa-connector"
	# manifest
	install -DTm644 manifests/termux.json "$CLANDRO_PREFIX/lib/mozilla/native-messaging-hosts/firefoxpwa.json"
	# completions
	install -Dm644 -t "$CLANDRO_PREFIX/share/bash-completion/completions" "$build_dir/completions/firefoxpwa.bash"
	install -Dm644 -t "$CLANDRO_PREFIX/share/fish/vendor_completions.d" "$build_dir/completions/firefoxpwa.fish"
	install -Dm644 -t "$CLANDRO_PREFIX/share/zsh/vendor-completions" "$build_dir/completions/_firefoxpwa"
	# UserChrome
	install -dm755 "$CLANDRO_PREFIX/share/firefoxpwa/userchrome"
	cp -r userchrome/* "$CLANDRO_PREFIX/share/firefoxpwa/userchrome/"
	# Documentation
	install -DTm644 ../README.md "$CLANDRO_PREFIX/share/doc/firefoxpwa/README.md"
	install -DTm644 ../native/README.md "$CLANDRO_PREFIX/share/doc/firefoxpwa/README-NATIVE.md"
	install -DTm644 ../extension/README.md "$CLANDRO_PREFIX/share/doc/firefoxpwa/README-EXTENSION.md"
	# AppStream Metadata
	install -Dm644 -t "$CLANDRO_PREFIX/share/metainfo" "packages/appstream/si.filips.FirefoxPWA.metainfo.xml"
	install -Dm644 -t "$CLANDRO_PREFIX/share/icons/hicolor/scalable/apps" "packages/appstream/si.filips.FirefoxPWA.svg"
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		firefoxpwa runtime install --link
		exit 0
	EOF
	cat <<-EOF > ./prerm
		#!${CLANDRO_PREFIX}/bin/sh
		firefoxpwa runtime uninstall
		exit 0
	EOF
	chmod +x ./postinst ./prerm
}
