CLANDRO_SUBPKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
CLANDRO_SUBPKG_DEPEND_ON_PARENT=deps
CLANDRO_SUBPKG_CONFLICTS="qemu-system-riscv64-headless"

CLANDRO_SUBPKG_INCLUDE="
bin/qemu-system-riscv64
share/man/man1/qemu-system-riscv64.1.gz
"
