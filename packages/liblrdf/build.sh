CLANDRO_PKG_HOMEPAGE=https://github.com/swh/LRDF
CLANDRO_PKG_DESCRIPTION="A library to make it easy to manipulate RDF files describing LADSPA plugins"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.6.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/swh/LRDF/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d579417c477ac3635844cd1b94f273ee2529a8c3b6b21f9b09d15f462b89b1ef
CLANDRO_PKG_DEPENDS="libraptor2"

clandro_step_pre_configure() {
	autoreconf -fi
}
