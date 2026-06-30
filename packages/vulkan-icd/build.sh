CLANDRO_PKG_HOMEPAGE=https://github.com/termux/termux-packages
CLANDRO_PKG_DESCRIPTION="A metapackage that provides Vulkan ICDs"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_METAPACKAGE=true

# XXX: Make buildorder.py happy
if [ true = true ]; then
	CLANDRO_PKG_DEPENDS="mesa-vulkan-icd-swrast"
	CLANDRO_PKG_DEPENDS+=" | mesa-vulkan-icd-freedreno"
	CLANDRO_PKG_DEPENDS+=" | swiftshader"
fi
