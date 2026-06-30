CLANDRO_PKG_HOMEPAGE=https://www.nginx.org
CLANDRO_PKG_DESCRIPTION="Lightweight HTTP server"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.30.0"
CLANDRO_PKG_SRCURL=https://nginx.org/download/nginx-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=058188c64bf22baecaa72b809a6318a4f9ba623889c554feab03f7cb853ab31b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libcrypt, pcre2, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SERVICE_SCRIPT=("nginx" "mkdir -p $CLANDRO_ANDROID_HOME/.nginx\nif [ -f \"$CLANDRO_ANDROID_HOME/.nginx/nginx.conf\" ]; then CONFIG=\"$CLANDRO_ANDROID_HOME/.nginx/nginx.conf\"; else CONFIG=\"$CLANDRO_PREFIX/etc/nginx/nginx.conf\"; fi\nexec nginx -p ~/.nginx -g \"daemon off;\" -c \$CONFIG 2>&1")
CLANDRO_PKG_CONFFILES="
etc/nginx/fastcgi.conf
etc/nginx/fastcgi_params
etc/nginx/koi-win
etc/nginx/koi-utf
etc/nginx/mime.types
etc/nginx/nginx.conf
etc/nginx/scgi_params
etc/nginx/uwsgi_params
etc/nginx/win-utf"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	CPPFLAGS="$CPPFLAGS -DIOV_MAX=1024"
	LDFLAGS="$LDFLAGS -landroid-glob"

	# for cpu_set_t
	CPPFLAGS+=" -D__USE_GNU=1"

	# remove config from previous installs
	rm -rf "$CLANDRO_PREFIX/etc/nginx"
}

clandro_step_configure() {
	DEBUG_FLAG=""
	$CLANDRO_DEBUG_BUILD && DEBUG_FLAG="--with-debug"

	./configure \
		--prefix=$CLANDRO_PREFIX \
		--crossbuild="Linux:3.16.1:$CLANDRO_ARCH" \
		--crossfile="$CLANDRO_PKG_SRCDIR/auto/cross/Android" \
		--with-cc=$CC \
		--with-cpp=$CPP \
		--with-cc-opt="$CPPFLAGS $CFLAGS" \
		--with-ld-opt="$LDFLAGS" \
		--with-threads \
		--sbin-path="$CLANDRO_PREFIX/bin/nginx" \
		--conf-path="$CLANDRO_PREFIX/etc/nginx/nginx.conf" \
		--http-log-path="$CLANDRO_PREFIX/var/log/nginx/access.log" \
		--pid-path="$CLANDRO_PREFIX/tmp/nginx.pid" \
		--lock-path="$CLANDRO_PREFIX/tmp/nginx.lock" \
		--error-log-path="$CLANDRO_PREFIX/var/log/nginx/error.log" \
		--http-client-body-temp-path="$CLANDRO_PREFIX/var/lib/nginx/client-body" \
		--http-proxy-temp-path="$CLANDRO_PREFIX/var/lib/nginx/proxy" \
		--http-fastcgi-temp-path="$CLANDRO_PREFIX/var/lib/nginx/fastcgi" \
		--http-scgi-temp-path="$CLANDRO_PREFIX/var/lib/nginx/scgi" \
		--http-uwsgi-temp-path="$CLANDRO_PREFIX/var/lib/nginx/uwsgi" \
		--with-http_auth_request_module \
		--with-http_realip_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_v3_module \
		--with-http_gunzip_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-stream \
		--with-stream_realip_module \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		$DEBUG_FLAG
}

clandro_step_post_make_install() {
	# many parts are taken directly from Arch PKGBUILD
	# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/nginx

	# set default port to 8080
	sed -i "s| 80;| 8080;|" "$CLANDRO_PREFIX/etc/nginx/nginx.conf"
	cp conf/mime.types "$CLANDRO_PREFIX/etc/nginx/"
	rm "$CLANDRO_PREFIX"/etc/nginx/*.default

	# move default html dir
	sed -e "s| html;| $CLANDRO_PREFIX/share/nginx/html;|" \
		-i "$CLANDRO_PREFIX/etc/nginx/nginx.conf"
	rm -rf "$CLANDRO_PREFIX/share/nginx"
	mkdir -p "$CLANDRO_PREFIX/share/nginx"
	mv "$CLANDRO_PREFIX/html/" "$CLANDRO_PREFIX/share/nginx"

	# install vim contrib
	for i in ftdetect indent syntax; do
		install -Dm644 "$CLANDRO_PKG_SRCDIR/contrib/vim/${i}/nginx.vim" \
			"$CLANDRO_PREFIX/share/vim/vimfiles/${i}/nginx.vim"
	done

	# install man pages
	mkdir -p "$CLANDRO_PREFIX/share/man/man8"
	cp "$CLANDRO_PKG_SRCDIR/man/nginx.8" "$CLANDRO_PREFIX/share/man/man8/"
}

clandro_step_post_massage() {
	# keep empty dirs which were deleted in massage
	mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/log/nginx"
	for dir in client-body proxy fastcgi scgi uwsgi; do
		mkdir -p "$CLANDRO_PKG_MASSAGEDIR/$CLANDRO_PREFIX/var/lib/nginx/$dir"
	done
}
