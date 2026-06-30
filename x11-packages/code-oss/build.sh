CLANDRO_PKG_HOMEPAGE=https://github.com/microsoft/vscode
CLANDRO_PKG_DESCRIPTION="Visual Studio Code - OSS"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@licy183"
CLANDRO_PKG_VERSION="1.117.0"
CLANDRO_PKG_SRCURL=git+https://github.com/microsoft/vscode
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_DEPENDS="electron-for-code-oss, libx11, libxkbfile, libsecret, ripgrep"
CLANDRO_PKG_BUILD_DEPENDS="electron-headers-for-code-oss"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="electron-for-code-oss"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_NO_STRIP=true
CLANDRO_PKG_HOSTBUILD=true
# Chromium doesn't support i686 on Linux.
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="latest-release-tag"
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

_setup_nodejs_22() {
	local NODEJS_VERSION=22.22.1
	local NODEJS_FOLDER=${CLANDRO_PKG_CACHEDIR}/build-tools/nodejs-${NODEJS_VERSION}

	if [ ! -x "$NODEJS_FOLDER/bin/node" ]; then
		mkdir -p "$NODEJS_FOLDER"
		local NODEJS_TAR_FILE=$CLANDRO_PKG_TMPDIR/nodejs-$NODEJS_VERSION.tar.xz
		clandro_download https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz \
			"$NODEJS_TAR_FILE" \
			9a6bc82f9b491279147219f6a18add1e18424dce90d41d2a5fcd69d4924ba3aa
		tar -xf "$NODEJS_TAR_FILE" -C "$NODEJS_FOLDER" --strip-components=1
	fi
	export PATH="$NODEJS_FOLDER/bin:$PATH"
}

clandro_step_post_get_source() {
	# Ensure that code-oss supports node 22
	local _node_version=$(cat .nvmrc | cut -d. -f1 -)
	if [ "$_node_version" != 22 ]; then
		clandro_error_exit "Version mismatch: Expected 22, got $_node_version."
	fi

	# Check whether the prebuilt electron version matches the electron version from package.json
	local _electron_verion="$(jq -r '.devDependencies.electron' $CLANDRO_PKG_SRCDIR/package.json)"
	local _header_version="$(. $CLANDRO_SCRIPTDIR/x11-packages/electron-host-tools-for-code-oss/build.sh; echo $CLANDRO_PKG_VERSION)"
	if [ "$_electron_verion" != "$_header_version" ]; then
		clandro_error_exit "Version mismatch: version in package.json is $_electron_verion, prebuilt electron version $_header_version."
	fi

	# Use custom node-native-keymap
	local _native_keymap_verion="$(jq -r ".dependencies.\"native-keymap\"" package.json | cut -d'^' -f2)"
	local _native_keymap_src_url="https://registry.npmjs.org/native-keymap/-/native-keymap-$_native_keymap_verion.tgz"
	local _native_keymap_sha256sum="SKIP_CHECKSUM"
	local _native_keymap_path="$CLANDRO_PKG_CACHEDIR/$(basename $_native_keymap_src_url)"
	clandro_download $_native_keymap_src_url $_native_keymap_path $_native_keymap_sha256sum
	mkdir -p $CLANDRO_PKG_SRCDIR/node-native-keymap-src
	tar -xf $_native_keymap_path -C $CLANDRO_PKG_SRCDIR/node-native-keymap-src --strip-components=1

	# Replace package.json
	jq ".dependencies.\"native-keymap\" = \"file:./node-native-keymap-src\"" package.json > package.json.tmp && mv package.json.tmp package.json
	jq ".dependencies.\"node-ovsx-sign\" = \"^1.2.0\"" package.json > package.json.tmp && mv package.json.tmp package.json
}

clandro_step_host_build() {
	_setup_nodejs_22
	export DISABLE_V8_COMPILE_CACHE=1
	(unset PREFIX prefix
	npm install node-gyp)
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/node_modules/.bin:$PATH"
}

clandro_step_configure() {
	_setup_nodejs_22
	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR/node_modules/.bin:$PATH"
}

clandro_step_make() {
	unset PREFIX prefix

	if [ $CLANDRO_ARCH = "arm" ]; then
		export NPM_CONFIG_ARCH=arm
		CODE_ARCH=armhf
	elif [ $CLANDRO_ARCH = "x86_64" ]; then
		export NPM_CONFIG_ARCH=x64
		CODE_ARCH=x64
	elif [ $CLANDRO_ARCH = "aarch64" ]; then
		export NPM_CONFIG_ARCH=arm64
		CODE_ARCH=arm64
	else
		clandro_error_exit "Unsupported arch: $CLANDRO_ARCH"
	fi
	export npm_config_arch=$NPM_CONFIG_ARCH
	export npm_config_nodedir=$CLANDRO_PREFIX/lib/code-oss/node_headers

	export CXX="$CXX -v -L$CLANDRO_PREFIX/lib"
	export CXXFLAGS="$CXXFLAGS -DSPDLOG_USE_STD_FORMAT=1"

	export DISABLE_V8_COMPILE_CACHE=1
	npm install
	npm run gulp vscode-linux-$CODE_ARCH-min
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/lib/code-oss

	# Copy resources
	rm -rf $CLANDRO_PREFIX/lib/code-oss/resources/
	mkdir -p $CLANDRO_PREFIX/lib/code-oss/resources/
	cp -r --no-preserve=ownership --preserve=mode package-build-root/VSCode-linux-$CODE_ARCH/resources/* $CLANDRO_PREFIX/lib/code-oss/resources/

	# Install the start script
	mkdir -p $CLANDRO_PREFIX/lib/code-oss/bin
	cp package-build-root/VSCode-linux-$CODE_ARCH/bin/code-oss $CLANDRO_PREFIX/lib/code-oss/bin/code-oss
	sed -i "s|/usr/bin|$CLANDRO_PREFIX/bin|g
			s|/usr/share/code-oss|$CLANDRO_PREFIX/lib/code-oss|g
			s|/proc/version|/dev/null|g" $CLANDRO_PREFIX/lib/code-oss/bin/code-oss
	chmod +x $CLANDRO_PREFIX/lib/code-oss/bin/code-oss

	# Replace ripgrep
	ln -sfr $CLANDRO_PREFIX/bin/rg $CLANDRO_PREFIX/lib/code-oss/resources/app/node_modules/@vscode/ripgrep/bin/rg

	# Install appdata and desktop file
	sed -i "s|@@NAME_SHORT@@|Code|g
			s|@@NAME_LONG@@|Code - OSS|g
			s|@@NAME@@|code-oss|g
			s|@@ICON@@|com.visualstudio.code.oss|g
			s|@@EXEC@@|$CLANDRO_PREFIX/bin/code-oss|g
			s|@@LICENSE@@|MIT|g" resources/linux/code{.appdata.xml,-workspace.xml,.desktop,-url-handler.desktop}
	install -Dm600 resources/linux/code.appdata.xml $CLANDRO_PREFIX/share/metainfo/code-oss.appdata.xml
	install -Dm600 resources/linux/code-workspace.xml $CLANDRO_PREFIX/share/mime/packages/code-oss.workspace.xml
	install -Dm600 resources/linux/code.desktop $CLANDRO_PREFIX/share/applications/code-oss.desktop
	install -Dm600 resources/linux/code-url-handler.desktop $CLANDRO_PREFIX/share/applications/code-oss-url-handler.desktop
	install -Dm600 package-build-root/VSCode-linux-$CODE_ARCH/resources/app/resources/linux/code.png $CLANDRO_PREFIX/share/pixmaps/com.visualstudio.code.oss.png

	# Install binaries to $PREFIX/bin
	ln -sfr $CLANDRO_PREFIX/lib/code-oss/bin/code-oss $CLANDRO_PREFIX/bin/code-oss
	ln -sfr $CLANDRO_PREFIX/bin/code-oss $CLANDRO_PREFIX/bin/code
	ln -sfr $CLANDRO_PREFIX/bin/code-oss $CLANDRO_PREFIX/bin/vscode

	# Install shell completions
	cp resources/completions/bash/code resources/completions/bash/code-oss
	cp resources/completions/bash/code resources/completions/bash/vscode
	cp resources/completions/zsh/_code resources/completions/zsh/_code-oss
	cp resources/completions/zsh/_code resources/completions/zsh/_vscode
	sed -i 's|@@APPNAME@@|code|g' resources/completions/{bash/code,zsh/_code}
	sed -i 's|@@APPNAME@@|vscode|g' resources/completions/{bash/vscode,zsh/_vscode}
	sed -i 's|@@APPNAME@@|code-oss|g' resources/completions/{bash/code-oss,zsh/_code-oss}
	install -Dm600 resources/completions/bash/code $CLANDRO_PREFIX/share/bash-completion/completions/code
	install -Dm600 resources/completions/zsh/_code $CLANDRO_PREFIX/share/zsh/site-functions/_code
	install -Dm600 resources/completions/bash/vscode $CLANDRO_PREFIX/share/bash-completion/completions/vscode
	install -Dm600 resources/completions/zsh/_vscode $CLANDRO_PREFIX/share/zsh/site-functions/_vscode
	install -Dm600 resources/completions/bash/code-oss $CLANDRO_PREFIX/share/bash-completion/completions/code-oss
	install -Dm600 resources/completions/zsh/_code-oss $CLANDRO_PREFIX/share/zsh/site-functions/_code-oss

	# Install license files
	mkdir -p $CLANDRO_PREFIX/share/doc/code-oss
	cp package-build-root/VSCode-linux-$CODE_ARCH/resources/app/LICENSE.txt $CLANDRO_PREFIX/share/doc/code-oss/LICENSE
	cp package-build-root/VSCode-linux-$CODE_ARCH/resources/app/ThirdPartyNotices.txt $CLANDRO_PREFIX/share/doc/code-oss/ThirdPartyNotices.txt
}
