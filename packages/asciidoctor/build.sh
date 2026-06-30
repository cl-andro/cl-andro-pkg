CLANDRO_PKG_HOMEPAGE=https://asciidoctor.org/
CLANDRO_PKG_DESCRIPTION="An implementation of AsciiDoc in Ruby"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.26"
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="ruby"
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	ruby_version=$(. $CLANDRO_SCRIPTDIR/packages/ruby/build.sh; echo $CLANDRO_PKG_VERSION)
}

clandro_step_make_install() {
	local gemdir="$CLANDRO_PREFIX/lib/ruby/gems/${ruby_version:0:3}.0"

	rm -rf "$gemdir/asciidoctor-$CLANDRO_PKG_VERSION"
	rm -rf "$gemdir/doc/asciidoctor-$CLANDRO_PKG_VERSION"

	gem install --ignore-dependencies --no-user-install --verbose \
		-i "$gemdir" -n "$CLANDRO_PREFIX/bin" asciidoctor -v "$CLANDRO_PKG_VERSION"

	sed -i -E "1 s@^(#\!)(.*)@\1${CLANDRO_PREFIX}/bin/ruby@" \
		"$CLANDRO_PREFIX/bin/asciidoctor"

	install -Dm600 "$gemdir/gems/asciidoctor-${CLANDRO_PKG_VERSION}/man/asciidoctor.1" \
		"$CLANDRO_PREFIX/share/man/main1/asciidoctor.1"
}

clandro_step_install_license() {
	local gemdir="$CLANDRO_PREFIX/lib/ruby/gems/${ruby_version:0:3}.0"
	mkdir -p $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME
	cp $gemdir/gems/asciidoctor-${CLANDRO_PKG_VERSION}/LICENSE \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/
}
