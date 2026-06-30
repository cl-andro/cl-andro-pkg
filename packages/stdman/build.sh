CLANDRO_PKG_HOMEPAGE=https://github.com/jeaye/stdman
CLANDRO_PKG_DESCRIPTION="Formatted C++23 stdlib man pages (cppreference)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2024.07.05
CLANDRO_PKG_SRCURL=https://github.com/jeaye/stdman/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3cd652cb76c4fc7604c2b961a726788550c01065032bcff0a706b44f2eb0f75a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="mandoc"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make() {
	# Just install manpages without building generation utility.
	:
}
