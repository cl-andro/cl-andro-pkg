# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://docker.com
CLANDRO_PKG_DESCRIPTION="Set of products that use OS-level virtualization to deliver software in packages called containers."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1:24.0.6
CLANDRO_PKG_REVISION=4
LIBNETWORK_COMMIT=67e0588f1ddfaf2faf4c8cae8b7ea2876434d91c
DOCKER_GITCOMMIT=ed223bc
CLANDRO_PKG_SRCURL=(https://github.com/moby/moby/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
                   https://github.com/docker/cli/archive/refs/tags/v${CLANDRO_PKG_VERSION:2}.tar.gz
                   https://github.com/moby/libnetwork/archive/${LIBNETWORK_COMMIT}.tar.gz)
CLANDRO_PKG_DEPENDS="containerd, libdevmapper, resolv-conf"
CLANDRO_PKG_SHA256=(29a8ee54e9ea008b40eebca42dec8b67ab257eb8ac175f67e79c110e4187d7d2
                   c1a4a580ced3633e489c5c9869a20198415da44df7023fdc200d425cdf5fa652
                   4ab6f6c97db834c2eedc053d06c4d32d268f33051b8148098b4a0e8eee51e97b)
CLANDRO_PKG_CONFFILES="etc/docker/daemon.json"
CLANDRO_PKG_SERVICE_SCRIPT=("dockerd" "exec su -c \"PATH=\$PATH $CLANDRO_PREFIX/bin/dockerd 2>&1\"")
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true

clandro_step_get_source() {
	local PKG_SRCURL=(${CLANDRO_PKG_SRCURL[@]})
	local PKG_SHA256=(${CLANDRO_PKG_SHA256[@]})

	if [ ${#PKG_SRCURL[@]} != ${#PKG_SHA256[@]} ]; then
		clandro_error_exit "length of CLANDRO_PKG_SRCURL isn't equal to length of CLANDRO_PKG_SHA256."
	fi

	# download and extract packages into its own folder inside $CLANDRO_PKG_SRCDIR
	mkdir -p "$CLANDRO_PKG_CACHEDIR"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	for i in $(seq 0 $(( ${#PKG_SRCURL[@]} - 1 ))); do
		# Archives from moby/moby and docker/cli have same name, so cache them as {moby,cli}-v...
		local file="${CLANDRO_PKG_CACHEDIR}/$(echo ${PKG_SRCURL[$i]}|cut -d"/" -f 5)-$(basename ${PKG_SRCURL[$i]})"
		clandro_download "${PKG_SRCURL[$i]}" "$file" "${PKG_SHA256[$i]}"
		tar xf "$file" -C "$CLANDRO_PKG_SRCDIR"
	done

	# delete trailing -$CLANDRO_PKG_VERSION from folder name
	# so patches become portable across different versions
	cd "$CLANDRO_PKG_SRCDIR"
	for folder in $(ls); do
		if [ ! $folder == ${folder%%-*} ]; then
			mv $folder ${folder%%-*}
		fi
	done
}

clandro_step_pre_configure() {
	# setup go build environment
	clandro_setup_golang
	export GO111MODULE=auto
}

clandro_step_make() {
	# BUILD DOCKERD DAEMON
	echo -n "Building dockerd daemon..."
	(
	set -e
	cd moby

	# issue the build command
	export DOCKER_GITCOMMIT
	export DOCKER_BUILDTAGS='exclude_graphdriver_btrfs exclude_graphdriver_devicemapper exclude_graphdriver_quota selinux exclude_graphdriver_aufs'
	AUTO_GOPATH=1 PREFIX='' hack/make.sh dynbinary
	)
	echo " Done!"

	# BUILD DOCKER-PROXY BINARY FROM LIBNETWORK
	echo -n "Building docker-proxy from libnetwork..."
	(
	set -e

	# fix path locations to build with go
	mkdir -p go/src/github.com/docker
	mv libnetwork go/src/github.com/docker
	mkdir libnetwork
	mv go libnetwork
	export GOPATH="${PWD}/libnetwork/go"
	cd "${GOPATH}/src/github.com/docker/libnetwork"

	# issue the build command
	go build -o docker-proxy github.com/docker/libnetwork/cmd/proxy
	)
	echo " Done!"

	# BUILD DOCKER-CLI CLIENT
	echo -n "Building docker-cli client..."
	(
	set -e

	# fix path locations to build with go
	mkdir -p go/src/github.com/docker
	mv cli go/src/github.com/docker
	mkdir cli
	mv go cli
	export GOPATH="${PWD}/cli/go"
	cd "${GOPATH}/src/github.com/docker/cli"

	# issue the build command
	export VERSION=v${CLANDRO_PKG_VERSION}-ce
	export DISABLE_WARN_OUTSIDE_CONTAINER=1
	export LDFLAGS="-L ${CLANDRO_PREFIX}/lib -r ${CLANDRO_PREFIX}/lib"
	make -j ${CLANDRO_PKG_MAKE_PROCESSES} dynbinary
	unset GOOS GOARCH CGO_LDFLAGS CC CXX CFLAGS CXXFLAGS LDFLAGS
	make -j ${CLANDRO_PKG_MAKE_PROCESSES} manpages
	)
	echo " Done!"
}

clandro_step_make_install() {
	install -Dm 700 moby/bundles/dynbinary-daemon/dockerd ${CLANDRO_PREFIX}/libexec/dockerd
	install -Dm 700 libnetwork/go/src/github.com/docker/libnetwork/docker-proxy ${CLANDRO_PREFIX}/bin/docker-proxy
	install -Dm 700 cli/go/src/github.com/docker/cli/build/docker-android-* ${CLANDRO_PREFIX}/bin/docker
	install -Dm 600 -t ${CLANDRO_PREFIX}/share/man/man1 cli/go/src/github.com/docker/cli/man/man1/*
	install -Dm 600 -t ${CLANDRO_PREFIX}/share/man/man5 cli/go/src/github.com/docker/cli/man/man5/*
	install -Dm 600 -t ${CLANDRO_PREFIX}/share/man/man8 cli/go/src/github.com/docker/cli/man/man8/*
	mkdir -p "${CLANDRO_PREFIX}"/etc/docker
	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		"${CLANDRO_PKG_BUILDER_DIR}"/daemon.json > "${CLANDRO_PREFIX}"/etc/docker/daemon.json
	chmod 600 "${CLANDRO_PREFIX}"/etc/docker/daemon.json
	sed -e "s|@CLANDRO_PREFIX@|$CLANDRO_PREFIX|g" \
		"${CLANDRO_PKG_BUILDER_DIR}/dockerd.sh" > "${CLANDRO_PREFIX}/bin/dockerd"
	chmod 700 "${CLANDRO_PREFIX}/bin/dockerd"
}

clandro_step_post_make_install() {
	# Running sv down dockerd kills just the "su" process but
	# leaves dockerd running (even though it is running in the
	# foreground). This finish script works around that.
	mkdir -p $CLANDRO_PREFIX/var/service/dockerd/
	{
		echo "#!$CLANDRO_PREFIX/bin/sh"
		echo "su -c pkill dockerd"
	} > $CLANDRO_PREFIX/var/service/dockerd/finish
	chmod u+x $CLANDRO_PREFIX/var/service/dockerd/finish
}

clandro_step_create_debscripts() {
	cat <<- EOF > postinst
		#!${CLANDRO_PREFIX}/bin/sh

		echo 'NOTE: Docker requires the kernel to support'
		echo 'device cgroups, namespace, VETH, among others.'
		echo
		echo 'To check a full list of features needed, run the script:'
		echo 'https://github.com/moby/moby/blob/master/contrib/check-config.sh'
	EOF
}
