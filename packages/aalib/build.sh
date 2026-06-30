CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/aa-project/
CLANDRO_PKG_DESCRIPTION="A portable ASCII art graphic library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.4rc5
CLANDRO_PKG_REVISION=13
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/aa-project/aalib-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$CLANDRO_PREFIX/share/info
--mandir=$CLANDRO_PREFIX/share/man
"

clandro_step_pre_configure() {
	local _bin=$CLANDRO_PKG_BUILDDIR/_wrapper/bin
	mkdir -p $_bin
	local _cc=$(basename $CC)
	cat <<-EOF > $_bin/$_cc
		#!$(command -v sh)
		_shared=
		for f in "\$@"; do
			case "\$f" in
				-shared ) _shared=1 ;;
			esac
		done
		exec "$(command -v $_cc)" "\$@" \${_shared:+-Wl,-rpath=$CLANDRO_PREFIX/lib}
	EOF
	chmod 0700 $_bin/$_cc
	export PATH=$_bin:$PATH
}
