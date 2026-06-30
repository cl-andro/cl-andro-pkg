CLANDRO_PKG_HOMEPAGE=https://bitbucket.org/dtsarkov/factplusplus
CLANDRO_PKG_DESCRIPTION="Re-implementation of the well-known FaCT Description Logic (DL) Reasoner"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="licensing/FaCT++.license.txt, licensing/lgpl-2.1.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.5
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://bitbucket.org/dtsarkov/factplusplus/downloads/FaCTpp-src-v${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=d76ce04073ad6523eeb3fc761c012b20e3062ff78406f9da3fd2076828264e4e
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/src"
}
