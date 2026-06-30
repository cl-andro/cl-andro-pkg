CLANDRO_SUBPKG_INCLUDE="
bin/lldb*
include/lldb/
lib/liblldb.so
lib/python${CLANDRO_PYTHON_VERSION}/site-packages
"
CLANDRO_SUBPKG_DESCRIPTION="LLVM-based debugger"
CLANDRO_SUBPKG_DEPENDS="clang, libandroid-spawn, libc++, libedit, libxml2, python, ncurses-ui-libs"
CLANDRO_SUBPKG_BREAKS="lldb-dev, lldb-static"
CLANDRO_SUBPKG_REPLACES="lldb-dev, lldb-static"
