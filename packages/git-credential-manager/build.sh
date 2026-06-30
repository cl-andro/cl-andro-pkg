CLANDRO_PKG_HOMEPAGE="https://aka.ms/gcm"
CLANDRO_PKG_DESCRIPTION="Cross-platform Git credential storage for multiple hosting providers"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.3"
CLANDRO_PKG_SRCURL="https://github.com/git-ecosystem/git-credential-manager/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=a9c1d7a89c620bea0df65623f25c62e66122d22557583ab390ed612d544884e9
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_DOTNET_VERSION=8.0
CLANDRO_PKG_DEPENDS="dotnet-host, dotnet-runtime-8.0"
CLANDRO_PKG_EXCLUDED_ARCHES="arm"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_dotnet
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
	clandro_dotnet_kill
}

# The concern about preventing `rm -rf "${CLANDRO_PREFIX}/lib"` from expanding to
# `rm -rf "/lib/"` is valid, but the suggested remedy of `${var:?}` is not how we
# prefer to handle null value errors.
# shellcheck disable=SC2115
clandro_step_make_install() {
	# Sanity check the variables used in the `rm`'s below, just in case.
	[[ -n "$CLANDRO_PREFIX" ]] || clandro_error_exit "CLANDRO_PREFIX is unset, this shouldn't even be possible."
	[[ -n "$CLANDRO_PKG_NAME" ]] || clandro_error_exit "CLANDRO_PKG_NAME is unset, this shouldn't even be possible."

	rm -rf "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}"
	mkdir -p "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}"
	cp -r "out/shared/Git-Credential-Manager/bin/Release/net${CLANDRO_DOTNET_VERSION}/${DOTNET_TARGET_NAME}/publish"/* "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}"
	ln -sf "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}/git-credential-manager" "$CLANDRO_PREFIX/bin"

	# Remove translations
	rm -rf "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}"/*/
	# Remove debug files
	rm "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}"/*.pdb
	# Remove duplicate license
	rm "${CLANDRO_PREFIX}/lib/${CLANDRO_PKG_NAME}/NOTICE"
}
