CLANDRO_PKG_HOMEPAGE=https://ebassi.github.io/graphene/
CLANDRO_PKG_DESCRIPTION="A thin layer of graphic data types"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=1.10
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.8
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/graphene/${_MAJOR_VERSION}/graphene-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a37bb0e78a419dcbeaa9c7027bcff52f5ec2367c25ec859da31dfde2928f279a
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_CONFLICTS="gst-plugins-base (<< 1.20.3-1)"
CLANDRO_PKG_BREAKS="gst-plugins-base (<< 1.20.3-1)"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

clandro_step_pre_configure() {
	clandro_setup_gir

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		local pywrap="$CLANDRO_PKG_BUILDDIR/_bin/python-wrapper"
		mkdir -p "$(dirname "$pywrap")"
		cat > "$pywrap" <<-EOF
			#!/bin/bash-static
			unset LD_LIBRARY_PATH
			exec /usr/bin/python3 "\$@"
		EOF
		chmod 0700 "$pywrap"
		echo "Applying wrap-python.diff"
		sed -e "s|@PYTHON_WRAPPER@|${pywrap}|g" \
			"$CLANDRO_PKG_BUILDER_DIR/wrap-python.diff" \
			| patch --silent -p1 -d "$CLANDRO_PKG_SRCDIR"
	fi
}
