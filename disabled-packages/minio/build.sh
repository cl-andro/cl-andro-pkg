CLANDRO_PKG_HOMEPAGE=https://min.io/
CLANDRO_PKG_DESCRIPTION="Multi-Cloud Object Storage"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.10.15.17.29.55"
_VERSION=$(sed 's/\./T/3;s/\./-/g' <<< $CLANDRO_PKG_VERSION)
CLANDRO_PKG_SRCURL=https://github.com/minio/minio/archive/refs/tags/RELEASE.${_VERSION}Z.tar.gz
CLANDRO_PKG_SHA256=be6d0bd3696c3a13a35f02d3a0280b64319c67918b4501c5c3d87f96d000085c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_SED_REGEXP='s/T/-/g;s/[^0-9-]//g;s/-/./g'
CLANDRO_PKG_DEPENDS="resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	local _COMMITID=$(git ls-remote https://github.com/minio/minio refs/tags/RELEASE.${_VERSION}Z | cut -f1)
	local _SHORTCOMMITID=$(git ls-remote https://github.com/minio/minio refs/tags/RELEASE.${_VERSION}Z | head -c 12)

	MINIOLDFLAGS="\
	-w -s \
	-X 'github.com/minio/minio/cmd.Version=${_VERSION}Z' \
	-X 'github.com/minio/minio/cmd.CopyrightYear=$(date +%Y)' \
	-X 'github.com/minio/minio/cmd.ReleaseTag=RELEASE.${_VERSION}Z'\
	-X 'github.com/minio/minio/cmd.CommitID=${_COMMITID}' \
	-X 'github.com/minio/minio/cmd.ShortCommitID=${_SHORTCOMMITID}' \
	-X 'github.com/minio/minio/cmd.GOPATH=$(go env GOPATH)' \
	-X 'github.com/minio/minio/cmd.GOROOT=$(go env GOROOT)' \
	"
	go build -tags kqueue -trimpath --ldflags="$MINIOLDFLAGS" -o minio
}
clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin minio
}
