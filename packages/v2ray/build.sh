CLANDRO_PKG_HOMEPAGE=https://www.v2fly.org/
CLANDRO_PKG_DESCRIPTION="A platform for building proxies to bypass network restrictions"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.48.0"
CLANDRO_PKG_SRCURL=git+https://github.com/v2fly/v2ray-core
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"

_RELEASE_URL=https://github.com/v2fly/v2ray-core/releases/download/v$CLANDRO_PKG_VERSION/v2ray-linux-64.zip
_RELEASE_SHA256=7399f48845e87864280a4e34084ac796cd22fa008fb0f34460526f659dbdfe52

clandro_pkg_auto_update() {
	local latest_tag
	latest_tag="$(clandro_github_api_get_tag)"
	(( ${#latest_tag} )) || {
		printf '%s\n' \
		'WARN: Auto update failure!' \
		"latest_tag=${latest_tag}"
	return
	} >&2

	latest_tag="${latest_tag#v}"

	if [[ "${latest_tag}" == "${CLANDRO_PKG_VERSION}" ]]; then
		echo "INFO: No update needed. Already at version '${CLANDRO_PKG_VERSION}'."
		return
	fi

	if [[ "${BUILD_PACKAGES}" == "false" ]]; then
		echo "INFO: package needs to be updated to ${latest_tag}."
		return
	fi

	local tmpdir sha
	tmpdir="$(mktemp -d)"
	curl -sLo "${tmpdir}/tmpfile" "https://github.com/v2fly/v2ray-core/releases/download/v$latest_tag/v2ray-linux-64.zip"
	sha="$(sha256sum "${tmpdir}/tmpfile" | cut -d ' ' -f 1)"

	sed \
		-e "s|^_RELEASE_SHA256=.*|_RELEASE_SHA256=${sha}|" \
		-i "${CLANDRO_PKG_BUILDER_DIR}/build.sh"

	rm -fr "${tmpdir}"

	printf '%s\n' 'INFO: Generated checksums:' "${sha}"
	clandro_pkg_upgrade_version "${latest_tag}"
}

clandro_step_post_get_source() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go get
	chmod +w $GOPATH -R

	clandro_download $_RELEASE_URL \
		$CLANDRO_PKG_CACHEDIR/v2ray-linux-64-$CLANDRO_PKG_VERSION.zip \
		$_RELEASE_SHA256
	mkdir -p $CLANDRO_PKG_SRCDIR/v2ray-linux-64
	unzip -d $CLANDRO_PKG_SRCDIR/v2ray-linux-64 $CLANDRO_PKG_CACHEDIR/v2ray-linux-64-$CLANDRO_PKG_VERSION.zip

	local d
	for d in go/pkg/mod/github.com/adrg/xdg*/; do
		sed 's|@CLANDRO_PREFIX@|'"${CLANDRO_PREFIX}"'|g' \
			$CLANDRO_PKG_BUILDER_DIR/0001-fix-config-paths.diff \
			| patch -p1 -d ${d}
	done
}

clandro_step_make() {
	export GOPATH=$CLANDRO_PKG_SRCDIR/go
	go build -o v2ray ./main
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin v2ray
	install -Dm600 -t $CLANDRO_PREFIX/share/v2ray release/config/*.json
	install -Dm600 -t $CLANDRO_PREFIX/share/v2ray $CLANDRO_PKG_SRCDIR/v2ray-linux-64/geoip.dat
	install -Dm600 -t $CLANDRO_PREFIX/share/v2ray $CLANDRO_PKG_SRCDIR/v2ray-linux-64/geosite.dat
	install -Dm600 -t $CLANDRO_PREFIX/share/v2ray $CLANDRO_PKG_SRCDIR/v2ray-linux-64/geoip-only-cn-private.dat
}
