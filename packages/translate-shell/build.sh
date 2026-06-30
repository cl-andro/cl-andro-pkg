CLANDRO_PKG_HOMEPAGE=https://www.soimort.org/translate-shell
CLANDRO_PKG_DESCRIPTION="Command-line translator using Google Translate, Bing Translator, Yandex.Translate, etc."
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.7.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/soimort/translate-shell/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f949f379779b9e746bccb20fcd180d041fb90da95816615575b49886032bcefa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, curl, gawk, less, rlwrap"
# hunspell - spell checking
# mpv - text-to-speech functionality
CLANDRO_PKG_SUGGESTS="hunspell, mpv"
CLANDRO_PKG_EXTRA_MAKE_ARGS="PREFIX=$CLANDRO_PREFIX"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
