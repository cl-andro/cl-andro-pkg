CLANDRO_PKG_HOMEPAGE=https://github.com/ayntgl/discordo
CLANDRO_PKG_DESCRIPTION="A lightweight, secure, and feature-rich Discord terminal client"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=cdd97ff900a099ca520e5a720c547780dd6de162
CLANDRO_PKG_VERSION=2025.08.06
CLANDRO_PKG_SRCURL=git+https://github.com/ayntgl/discordo
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_SHA256=030bfd86b518586ca520891c0af5b1b32c0285260d825a0ddccdd7eec5d920ae
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_DEPENDS="libx11"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [[ "$version" != "$CLANDRO_PKG_VERSION" ]]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod download

	# golang's "mobile" package contains both code related to SurfaceFlinger(ANativeWindow[For Building an APK]),
	# and also X11-related code that upstream connects to "linux && !android".
	# apply the pattern "treat Android as linux" here,
	# to force the disabling of the SurfaceFlinger-dependent
	# code and the enabling of the X11-related code,
	# fixing the error when building discordo using NDK r28c:
	# android.c:171:52: error: incompatible pointer to integer conversion
	# passing 'ANativeWindow *' (aka 'struct ANativeWindow *') to parameter
	# of type 'EGLNativeWindowType' (aka 'unsigned long') [-Wint-conversion]
	for go_module in golang.org/x/mobile golang.design/x/clipboard; do
		cp --no-preserve=mode,ownership -rf "${GOPATH}"/pkg/mod/"${go_module}"\@* ./"${go_module##*/}"
		find ./"${go_module##*/}" -type f | \
			xargs -n 1 sed -i \
			-e 's|build android|build disabling_this_because_it_is_for_building_an_apk|g' \
			-e 's|linux && !android|linux|g' \
			-e 's|linux,!android|linux|g'
		local go_module_version=$(grep "${go_module}" go.mod | awk '{print $2}')
		go mod edit -replace "${go_module}@${go_module_version}=./${go_module##*/}"
	done
}

clandro_step_make() {
	go build -trimpath -buildmode=pie -ldflags "-s -w" .
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin "$CLANDRO_PKG_SRCDIR"/discordo
}
