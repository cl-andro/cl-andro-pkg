CLANDRO_PKG_HOMEPAGE=https://curl.se/docs/caextract.html
CLANDRO_PKG_DESCRIPTION="Common CA certificates"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:2026.03.19"
CLANDRO_PKG_SRCURL=https://curl.se/ca/cacert-$(sed 's/\./-/g' <<< ${CLANDRO_PKG_VERSION:2}).pem
CLANDRO_PKG_SHA256=b6e66569cc3d438dd5abe514d0df50005d570bfc96c14dca8f768d020cb96171
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	local CERTDIR=$CLANDRO_PREFIX/etc/tls
	local CERTFILE=$CERTDIR/cert.pem

	mkdir -p $CERTDIR

	clandro_download $CLANDRO_PKG_SRCURL \
		$CERTFILE \
		$CLANDRO_PKG_SHA256
	touch $CERTFILE

	# Build java keystore which is split out into a ca-certificates-java subpackage:
	local KEYUTIL_JAR=$CLANDRO_PKG_CACHEDIR/keyutil-0.4.0.jar
	clandro_download \
		https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar \
		$KEYUTIL_JAR \
		18f1d2c82839d84949b1ad015343c509e81ef678c24db6112acc6c0761314610

	local JAVA_KEYSTORE_DIR=$CLANDRO_PREFIX/lib/jvm/java-17-openjdk/lib/security
	mkdir -p $JAVA_KEYSTORE_DIR

	java -jar $KEYUTIL_JAR \
		--import \
		--new-keystore $JAVA_KEYSTORE_DIR/jssecacerts \
		--password changeit \
		--force-new-overwrite \
		--import-pem-file $CERTFILE
}
