CLANDRO_PKG_HOMEPAGE=https://containerd.io/
CLANDRO_PKG_DESCRIPTION="An open and reliable container runtime"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Be sure to test docker before pushing an update. With 1.6.24 or
# 1.7.7 we get the following error:
# $ sudo docker run -it ubuntu bash
# docker: Error response from daemon: failed to create task for container: failed to start shim: start failed: io.containerd.runc.v2: create new shim socket: listen unix /data/data/com.zk.clandro/files/usr/var/run/containerd/s/3f71828f1d6c1ead43fded842abc9c3cf5857c74c3e0704cd83ab177e17cfe6c: bind: invalid argument: exit status 1: unknown.
#
# Above error is fixed by too_long_path.patch
CLANDRO_PKG_VERSION=1.6.21
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=git+https://github.com/containerd/containerd
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="runc"
CLANDRO_PKG_CONFFILES="etc/containerd/config.toml"

clandro_step_post_get_source() {
	echo "github.com/cpuguy83/go-md2man/v2" >> vendor/modules.txt
}

clandro_step_make() {
	# setup go build environment
	clandro_setup_golang
	go env -w GO111MODULE=auto
	export GOPATH="${PWD}/go"
	mkdir -p "${GOPATH}/src/github.com/containerd"
	ln -sf "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/containerd/containerd"
	cd "${GOPATH}/src/github.com/containerd/containerd"

	# issue the build command
	export BUILDTAGS=no_btrfs
	SHIM_CGO_ENABLED=1 make -j ${CLANDRO_PKG_MAKE_PROCESSES}
	(unset GOOS GOARCH CGO_LDFLAGS CC CXX CFLAGS CXXFLAGS LDFLAGS
	make -j ${CLANDRO_PKG_MAKE_PROCESSES} man)

}

clandro_step_make_install() {
	cd "${GOPATH}/src/github.com/containerd/containerd"
	DESTDIR= make install
	DESTDIR= make install-man
	install -Dm 600 ${CLANDRO_PKG_BUILDER_DIR}/config.toml ${CLANDRO_PREFIX}/etc/containerd/config.toml
}
