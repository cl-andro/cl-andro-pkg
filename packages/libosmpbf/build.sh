CLANDRO_PKG_HOMEPAGE=https://github.com/openstreetmap/OSM-binary/
CLANDRO_PKG_DESCRIPTION="osmpbf is a Java/C library to read and write OpenStreetMap PBF files"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/openstreetmap/OSM-binary/archive/refs/tags/v${CLANDRO_PKG_VERSION}.zip
CLANDRO_PKG_SHA256=edd98ba252c81372113747a131466f5ba45e0cff97b597e863a26e83943ba84f
CLANDRO_PKG_DEPENDS="libc++, libprotobuf"
CLANDRO_PKG_GROUPS="science"

clandro_step_pre_configure() {
	clandro_setup_protobuf

	CPPFLAGS+=" -DPROTOBUF_USE_DLLS"

	# the error for 32-bit targets if this is not used looks like this:
	# ld.lld: error: undefined symbol: char const*
	# absl::lts_20250127::log_internal::MakeCheckOpString<long
	# long, long long>(long long, long long, char const*)
	# >>> referenced by osmformat.pb.cc
	# >>>               osmformat.pb.cc.o:(google::protobuf::RepeatedField<int>::GrowNoAnnotate(bool,
	# int, int)) in archive osmpbf/libosmpbf.a
	LDFLAGS+=" $($CLANDRO_SCRIPTDIR/packages/libprotobuf/interface_link_libraries.sh)"
}
