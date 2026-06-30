# Contributor: @craigcomstock
CLANDRO_PKG_HOMEPAGE=https://cfengine.com/
CLANDRO_PKG_DESCRIPTION="CFEngine is a configuration management technology"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:3.25.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=git+https://github.com/cfengine/core
CLANDRO_PKG_SHA256=c87921e5357ce4ef9b532ca4ac7a13ffc414f8a07f4f41416da6df4aae40c7ba
# "-build[n]" suffix in tag name is not a part of version string.
_CFENGINE_GIT_TAG_SUFFIX=
CLANDRO_PKG_GIT_BRANCH=${CLANDRO_PKG_VERSION#*:}${_CFENGINE_GIT_TAG_SUFFIX}
CLANDRO_PKG_DEPENDS="libandroid-glob, liblmdb, libxml2, libyaml, openssl, pcre2, librsync"
# core doesn't work with out-of-tree builds
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-workdir=$CLANDRO_PREFIX/var/lib/cfengine
--without-pam
--without-selinux-policy
--without-systemd-service
--with-lmdb=$CLANDRO_PREFIX
--with-openssl=$CLANDRO_PREFIX
--with-yaml=$CLANDRO_PREFIX
--with-pcre2=$CLANDRO_PREFIX
--with-prefix=$CLANDRO_PREFIX
--with-libxml2=$CLANDRO_PREFIX
"

clandro_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		clandro_error_exit "Checksum mismatch for source files. \nExpected ${CLANDRO_PKG_SHA256}\nActual ${s% *}"
	fi

	: ${_CFENGINE_GIT_TAG_SUFFIX:=}
	local _MASTERFILES_VERSION=${CLANDRO_PKG_VERSION#*:}${_CFENGINE_GIT_TAG_SUFFIX}
	local _MASTERFILES_SRCURL=https://github.com/cfengine/masterfiles/archive/${_MASTERFILES_VERSION}.zip
	local _MASTERFILES_SHA256=0bc9780001637291701e979a42d7d1628edb1c471cc4d744e2f44aa4c5e3ec42

	local _MASTERFILES_FILE=${CLANDRO_PKG_CACHEDIR}/masterfiles-${_MASTERFILES_VERSION}.zip
	clandro_download \
		${_MASTERFILES_SRCURL} \
		${_MASTERFILES_FILE} \
		${_MASTERFILES_SHA256}
	local d=$(unzip -qql ${_MASTERFILES_FILE} | \
			head -n1 | tr -s ' ' | cut -d' ' -f5-)
	unzip -q ${_MASTERFILES_FILE}
	mv ${d} masterfiles
}

clandro_step_pre_configure() {
	export EXPLICIT_VERSION=${CLANDRO_PKG_VERSION#*:}
	export LDFLAGS+=" -landroid-glob"
	NO_CONFIGURE=1 ./autogen.sh
}

clandro_step_post_make_install() {
	cd masterfiles
	./autogen.sh \
		--prefix=$CLANDRO_PREFIX/var/lib/cfengine \
		--bindir=$CLANDRO_PREFIX/bin
	make install
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		# Generate a host key
		if [ ! -f $CLANDRO_PREFIX/var/lib/cfengine/ppkeys/localhost.priv ]; then
			$CLANDRO_PREFIX/bin/cf-key >/dev/null || :
		fi
	EOF
}
