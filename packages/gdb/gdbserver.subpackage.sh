CLANDRO_SUBPKG_INCLUDE="
bin/gdbserver
share/man/man1/gdbserver.*
"
CLANDRO_SUBPKG_DESCRIPTION="The gdbserver program"
CLANDRO_SUBPKG_DEPENDS="libc++, libthread-db"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=false
CLANDRO_SUBPKG_BREAKS="gdb (<< 13.1)"
CLANDRO_SUBPKG_REPLACES="gdb (<< 13.1)"
