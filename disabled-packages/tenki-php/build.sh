CLANDRO_PKG_HOMEPAGE=https://github.com/dmpop/tenki
CLANDRO_PKG_DESCRIPTION="A simple PHP application for logging current weather conditions, notes, and waypoints"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
_COMMIT=cb07deb9d8c8fc5849f8752f6f0605f72f96fd9b
CLANDRO_PKG_VERSION=2022.05.26
CLANDRO_PKG_SRCURL=git+https://github.com/dmpop/tenki
CLANDRO_PKG_SHA256=7bdea2d3e09709d6562503833c4cd995aa40303a14c75f6a4338dfd40750d2ca
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_GIT_BRANCH=main
CLANDRO_PKG_DEPENDS="apache2, php"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_post_get_source() {
	git fetch --unshallow
	git checkout $_COMMIT

	local version="$(git log -1 --format=%cs | sed 's/-/./g')"
	if [ "$version" != "$CLANDRO_PKG_VERSION" ]; then
		echo -n "ERROR: The specified version \"$CLANDRO_PKG_VERSION\""
		echo " is different from what is expected to be: \"$version\""
		return 1
	fi

	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_make_install() {
	local _TENKI_ROOT=$CLANDRO_PREFIX/share/tenki-php
	rm -rf ${_TENKI_ROOT}
	mkdir -p ${_TENKI_ROOT}
	cp -a $CLANDRO_PKG_SRCDIR/* ${_TENKI_ROOT}/
	local _APACHE_CONF_DIR=$CLANDRO_PREFIX/etc/apache2/conf.d
	mkdir -p ${_APACHE_CONF_DIR}
	sed -e "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" \
		$CLANDRO_PKG_BUILDER_DIR/tenki-php.conf \
		> ${_APACHE_CONF_DIR}/tenki-php.conf
}
