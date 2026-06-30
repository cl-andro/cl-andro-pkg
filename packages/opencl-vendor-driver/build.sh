CLANDRO_PKG_HOMEPAGE=https://cl-andro.github.io
CLANDRO_PKG_DESCRIPTION="OpenCL driver from system vendor"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_RECOMMENDS="llvm, ocl-icd, patchelf"
CLANDRO_PKG_SKIP_SRC_EXTRACT=true

clandro_step_make_install() {
	echo "${CLANDRO_PREFIX}/opt/vendor/lib/libOpenCL.so" > vendor.icd
	install -Dm644 vendor.icd "${CLANDRO_PREFIX}/etc/OpenCL/vendors/vendor.icd"
	install -Dm644 /dev/null "${CLANDRO_PREFIX}/opt/vendor/lib/libOpenCL.so"
}

clandro_step_create_debscripts() {
	cp -f "${CLANDRO_PKG_BUILDER_DIR}/postinst.sh" postinst
	sed -i postinst -e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g"

	cat <<- EOF > prerm
	#!${CLANDRO_PREFIX}/bin/sh
	case "\$1" in
	purge|remove)
	rm -fr "${CLANDRO_PREFIX}/opt/vendor/lib"
	esac
	EOF
}

# Goal:
# To allow Termux to use on-device OpenCL drivers without export
# LD_LIBRARY_PATH=/vendor/lib64 or other trickery

# What it does:
# Copies libOpenCL.so from /vendor or /system
# Find extra deps for libOpenCL.so
# Patchelf libOpenCL.so and deps

# List of libOpenCL.so drivers from different vendors:
# GPU                    SONAME             cl_khr_icd    Supported
# Arm Mali               libGLES_mali.so    y             y
# Qualcomm Adreno        libOpenCL.so       n             n
# Imagination PowerVR    libPVROCL.so       y             y
