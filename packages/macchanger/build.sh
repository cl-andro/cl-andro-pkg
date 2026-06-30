# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/alobbs/macchanger
CLANDRO_PKG_DESCRIPTION="Utility that makes the maniputation of MAC addresses of network interfaces easier"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.7.0
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/alobbs/macchanger/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1d75c07a626321e07b48a5fe2dbefbdb98c3038bb8230923ba8d32bda5726e4f

clandro_step_pre_configure() {
	./autogen.sh
}
