# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/nxtrace/Ntrace-V1
CLANDRO_PKG_DESCRIPTION="An open source visual routing tool that pursues light weight"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.4"
CLANDRO_PKG_SRCURL=https://github.com/nxtrace/Ntrace-V1/archive/refs/tags/v${CLANDRO_PKG_VERSION//\~/-}.tar.gz
CLANDRO_PKG_SHA256=9eba5cb048f73ed28ab81339a26cd6a47b839c2ae8811541c4b9718e90ce7227
CLANDRO_PKG_BREAKS="nexttrace-enhanced"
CLANDRO_PKG_REPLACES="nexttrace-enhanced"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	local _BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
	local _COMMIT_SHA1=$(git ls-remote https://github.com/nxtrace/Ntrace-V1 refs/tags/v$CLANDRO_PKG_VERSION | head -c 9)
	go build -trimpath -o nexttrace \
	-ldflags "-X 'github.com/nxtrace/NTrace-core/config.Version=${CLANDRO_PKG_VERSION}' \
	-X 'github.com/nxtrace/NTrace-core/config.BuildDate=${_BUILD_DATE}' \
	-X 'github.com/nxtrace/NTrace-core/config.CommitID=${_COMMIT_SHA1}' -w -s"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}"/bin nexttrace
}
