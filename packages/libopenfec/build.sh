CLANDRO_PKG_HOMEPAGE=http://openfec.org
CLANDRO_PKG_DESCRIPTION="Application-Level Forward Erasure Correction implementation library"
CLANDRO_PKG_LICENSE="CeCILL-C"
CLANDRO_PKG_LICENSE_FILE="LICENCE_CeCILL-C_V1-en.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.2.12"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/roc-project/openfec/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3397f58c8fff945ece8ea19e7859040c98a5c6497e5d791397794094e15e5873
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libopenfec-dev"
CLANDRO_PKG_REPLACES="libopenfec-dev"

clandro_step_make_install() {
	install -Dm600 "$CLANDRO_PKG_SRCDIR/bin/Release/libopenfec.so" "$CLANDRO_PREFIX/lib/libopenfec.so"

	cd $CLANDRO_PKG_SRCDIR/src
	local include; for include in $(find . -type f -iname \*.h | sed 's@^\./@@'); do
		install -Dm600 "$include" "$CLANDRO_PREFIX"/include/openfec/"$include"
	done
}
