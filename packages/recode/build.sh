# Contributor: @s00se
CLANDRO_PKG_HOMEPAGE="https://github.com/pinard/Recode"
CLANDRO_PKG_DESCRIPTION="Charset converter tool and library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.7.15"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/rrthomas/recode/releases/download/v${CLANDRO_PKG_VERSION}/recode-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f590407fc51badb351973fc1333ee33111f05ec83a8f954fd8cf0c5e30439806
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libiconv"
# recode needs to be explicitly linked to avoid:
# CANNOT LINK EXECUTABLE "recode": cannot locate symbol "libiconv_open"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="LIBS=-liconv"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
ac_cv_path_HELP2MAN=:
"
