CLANDRO_PKG_HOMEPAGE=https://libuv.org
CLANDRO_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
CLANDRO_PKG_LICENSE="MIT, BSD 2-Clause, ISC, BSD 3-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.52.1"
CLANDRO_PKG_SRCURL=https://dist.libuv.org/dist/v${CLANDRO_PKG_VERSION}/libuv-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=66d511b9e6e334c0e62279eb234fbfb2b3110b1479c09b95b44c7afca8cff9e7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libuv-dev"
CLANDRO_PKG_REPLACES="libuv-dev"

clandro_step_pre_configure() {
	export PLATFORM=android
	sh autogen.sh
}
