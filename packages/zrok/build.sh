CLANDRO_PKG_HOMEPAGE=https://zrok.io/
CLANDRO_PKG_DESCRIPTION="An open source sharing solution built on OpenZiti."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="1.1.11"
# do not use /archive/refs/tags/ URL link to avoid retagging
CLANDRO_PKG_SRCURL=https://github.com/openziti/zrok/releases/download/v${CLANDRO_PKG_VERSION}/source-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=374da7b0cea19c2fa284d8dec5145e3b2374976d23d0f432e1dbcf07c0285073
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	:
}

clandro_step_make() {
	clandro_setup_nodejs
	clandro_setup_golang

	dirs=("ui" "agent/agentUi")
	for dir in "${dirs[@]}"; do
		pushd "$dir"
		npm install
		npm run build
		popd
	done

	mkdir -p  "$CLANDRO_PKG_SRCDIR/dist"

	export GOPATH="$CLANDRO_PKG_BUILDDIR"
	export LDFLAGS="-s -w -X main.VERSION=${CLANDRO_PKG_VERSION}"
	go build -o dist ./...
}

clandro_step_make_install() {
	# I have taken the liberty to give the binaries less generic names.
	install -Dm700 $CLANDRO_PKG_SRCDIR/dist/copyto $CLANDRO_PREFIX/bin/zrok-cp
	install -Dm700 $CLANDRO_PKG_SRCDIR/dist/http-server $CLANDRO_PREFIX/bin/zrok-server
	install -Dm700 $CLANDRO_PKG_SRCDIR/dist/pastefrom $CLANDRO_PREFIX/bin/zrok-paste
	install -Dm700 $CLANDRO_PKG_SRCDIR/dist/zrok $CLANDRO_PREFIX/bin/zrok
}

clandro_step_create_debscripts() {
	# Give proper notice that the generically named
	# ancillary binaries have been renamed
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
		echo "Some of Zrok's binaries have been renamed in this package!"
		echo "copyto -> zrok-cp"
		echo "pastefrom -> zrok-paste"
		echo "http-server -> zrok-server"
		echo
		echo "The main zrok binary is unchanged"
		echo "and the usage of the ancillary binaries is unchanged"
		echo "except for the name."
	exit 0
	POSTINST_EOF

	chmod 0755 postinst

	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
}
