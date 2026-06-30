CLANDRO_PKG_HOMEPAGE=https://duckdb.org/
CLANDRO_PKG_DESCRIPTION="An in-process SQL OLAP database management system"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.2"
CLANDRO_PKG_AUTO_UPDATE=true
# we clone to retain the .git directory, to ensure the version in the built executable is correctly populated
CLANDRO_PKG_SRCURL=git+https://github.com/duckdb/duckdb
CLANDRO_PKG_DEPENDS="libc++, openssl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_EXTENSIONS='icu;parquet;json;autocomplete' -DDUCKDB_EXPLICIT_PLATFORM=linux_arm64_android"

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
	CXXFLAGS+=" -D_GLIBCXX_USE_CXX11_ABI=1"
}
