CLANDRO_PKG_HOMEPAGE=https://homepages.laas.fr/mallet/soft/shell/eltclsh
CLANDRO_PKG_DESCRIPTION="Interactive shell for TCL programming language"
## per https://directory.fsf.org/wiki/Eltclsh and their ports http://robotpkg.openrobots.org/robotpkg/shell/eltclsh/ and embedded license headers in init.tcl
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="1.20"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.openrobots.org/distfiles/eltclsh/eltclsh-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5f87964f4100a707f34f9414c6c35f64f3626c1ff29c78e665ad2a5fd4011e43
CLANDRO_PKG_DEPENDS="libandroid-support, libedit, tcl"
CLANDRO_PKG_BUILD_DEPENDS="tk"
CLANDRO_PKG_SUGGESTS="tk"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_post_get_source() {
	sed -ne '/Copyright/,/ADVISED OF THE POSSIBILITY OF SUCH DAMAGE./s%^# %%p' "$CLANDRO_PKG_SRCDIR/tcl/init.tcl" > "$CLANDRO_PKG_SRCDIR/copyright"
}
