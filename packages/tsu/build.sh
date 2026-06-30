CLANDRO_PKG_HOMEPAGE=https://github.com/cswl/tsu
CLANDRO_PKG_DESCRIPTION="A su wrapper for Termux"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=8.6.0
CLANDRO_PKG_REVISION=1
_COMMIT=800b448becafb0186eecc366c50442ed9f8bb944
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SRCURL=git+https://github.com/cswl/tsu
CLANDRO_PKG_GIT_BRANCH=v8

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT
}

clandro_step_make() {
	python3 ./extract_usage.py
}

clandro_step_make_install() {
	# There is no install.sh script in the repository for now
	mkdir -p "$CLANDRO_PREFIX/bin"
	install -Dm755 tsu "$CLANDRO_PREFIX/bin"
	# sudo - is an included addon in tsu now
	ln -sf "$CLANDRO_PREFIX/bin/tsu" "$CLANDRO_PREFIX/bin/sudo"
}
