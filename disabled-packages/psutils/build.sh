CLANDRO_PKG_HOMEPAGE=https://github.com/rrthomas/psutils
CLANDRO_PKG_DESCRIPTION="A set of postscript utilities"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.10"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/rrthomas/psutils/releases/download/v${CLANDRO_PKG_VERSION}/psutils-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6f8339fd5322df5c782bfb355d9f89e513353220fca0700a5a28775404d7e98b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ghostscript, perl, libpaper"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_PAPER=${CLANDRO_PREFIX}/bin/paper"

clandro_step_post_massage() {
	local perl_version
	perl_version=$(
		. "${CLANDRO_SCRIPTDIR}"/packages/perl/build.sh
		echo "${CLANDRO_PKG_VERSION[0]}"
	)

	# Make sure that perl can find PSUtils module.
	mkdir -p "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib/perl5/${perl_version}"
	mv -f "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}"/share/psutils/PSUtils.pm \
		"${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}/lib/perl5/${perl_version}"/
	rmdir "${CLANDRO_PKG_MASSAGEDIR}/${CLANDRO_PREFIX}"/share/psutils
}
