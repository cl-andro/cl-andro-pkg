CLANDRO_PKG_HOMEPAGE=https://git.osgeo.org/gitea/rttopo/librttopo
CLANDRO_PKG_DESCRIPTION="The RT Topology Library exposes an API to create and manage standard topologies"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=git+https://git.osgeo.org/gitea/rttopo/librttopo
CLANDRO_PKG_GIT_BRANCH="librttopo-$CLANDRO_PKG_VERSION"
CLANDRO_PKG_SHA256=98c8a5acbc4db5fbe5ccb03c9577221bda1135c50301f45d67d6f8d2405feb3f
CLANDRO_PKG_DEPENDS="libgeos, proj"
CLANDRO_PKG_GROUPS="science"

clandro_step_post_get_source() {
	local s=$(find . -type f ! -path '*/.git/*' -print0 | xargs -0 sha256sum | LC_ALL=C sort | sha256sum)
	if [[ "${s}" != "${CLANDRO_PKG_SHA256}  "* ]]; then
		echo "$s"
		clandro_error_exit "Checksum mismatch for source files."
	fi
}

clandro_step_pre_configure() {
	./autogen.sh
}
