CLANDRO_PKG_HOMEPAGE=https://grafana.com/
CLANDRO_PKG_DESCRIPTION="The open-source platform for monitoring and observability"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:12.3.3"
CLANDRO_PKG_SRCURL=git+https://github.com/grafana/grafana
CLANDRO_PKG_BUILD_DEPENDS="yarn"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="SPEC_TARGET= MERGED_SPEC_TARGET="
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

clandro_step_post_get_source() {
	clandro_setup_golang
	go work vendor
}

clandro_step_pre_configure() {
	clandro_setup_nodejs

	export YARN_ENABLE_HARDENED_MODE=0

	local bin="$CLANDRO_PKG_BUILDDIR/_bin"
	mkdir -p "$bin"

	local yarn="$bin/yarn"
	cat > "$yarn" <<-EOF
		#!$(command -v sh)
		exec sh $CLANDRO_PREFIX/bin/yarn "\$@"
		EOF
	chmod 0755 "$yarn"

	export PATH="$bin:$PATH"

	NODE_OPTIONS+=" --max-old-space-size=6000"
	NODE_OPTIONS+=" --openssl-legacy-provider"
}

clandro_step_make() {
	GO_BUILD_FLAGS="-goos=$(go env GOOS) -goarch=$(go env GOARCH) -cc=$(go env CC)" \
		GOOS=linux GOARCH=amd64 \
		make "$CLANDRO_PKG_EXTRA_MAKE_ARGS" build-go
	make "$CLANDRO_PKG_EXTRA_MAKE_ARGS" deps-js
	# get rid of unnecessary things during build to not run out of storage
	rm -r .yarn/cache node_modules/@storybook
	make "$CLANDRO_PKG_EXTRA_MAKE_ARGS" build-js
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin bin/*/grafana-server bin/*/grafana-cli bin/*/grafana
	local sharedir="$CLANDRO_PREFIX/share/grafana"
	mkdir -p "$sharedir"
	for d in conf public; do
		cp -rT $d "$sharedir"/$d
	done
}
