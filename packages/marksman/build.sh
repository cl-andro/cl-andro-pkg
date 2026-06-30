CLANDRO_PKG_HOMEPAGE="https://github.com/artempyanykh/marksman"
CLANDRO_PKG_DESCRIPTION="LSP language server for editing Markdown files"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="2026.02.08"
CLANDRO_PKG_SRCURL="https://github.com/artempyanykh/marksman/archive/refs/tags/${CLANDRO_PKG_VERSION//\./-}.tar.gz"
CLANDRO_PKG_SHA256=a3ba5f8ef5be5d7ede2ec5ae9f303d2d776f476734ff66254be8e6df0e0f090e
CLANDRO_PKG_DEPENDS="dotnet-host, dotnet-runtime-9.0"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP="s/-/./g"

clandro_step_pre_configure() {
	CLANDRO_DOTNET_VERSION=9.0
	clandro_setup_dotnet

	local patch="$CLANDRO_PKG_BUILDER_DIR/version.diff"
	echo "Applying patch: $patch"
	sed -e "s%\@CLANDRO_PKG_VERSION\@%${CLANDRO_PKG_VERSION}%g" \
		"$patch" | patch --silent -p1
}

clandro_step_make() {
	dotnet publish \
	--framework "net${CLANDRO_DOTNET_VERSION}" \
	--no-self-contained \
	--runtime "$DOTNET_TARGET_NAME" \
	--configuration Release \
	-p:AssemblyVersion="${CLANDRO_PKG_VERSION}" \
	-p:FileVersion="${CLANDRO_PKG_VERSION}" \
	-p:InformationalVersion="${CLANDRO_PKG_VERSION}" \
	-p:Version="${CLANDRO_PKG_VERSION}"
	dotnet build-server shutdown
}

clandro_step_make_install() {
	mkdir -p "$CLANDRO_PREFIX/lib/marksman"
	cp -r "Marksman/bin/Release/net${CLANDRO_DOTNET_VERSION}/$DOTNET_TARGET_NAME/publish"/*.dll "${CLANDRO_PREFIX}/lib/marksman"
	cp    "Marksman/bin/Release/net${CLANDRO_DOTNET_VERSION}/$DOTNET_TARGET_NAME/publish/marksman.runtimeconfig.json" "${CLANDRO_PREFIX}/lib/marksman/"
	cat > "$CLANDRO_PREFIX/bin/marksman" <<-HERE
	#!$CLANDRO_PREFIX/bin/sh
	exec dotnet $CLANDRO_PREFIX/lib/marksman/marksman.dll "\$@"
	HERE
	chmod u+x "$CLANDRO_PREFIX/bin/marksman"
}
