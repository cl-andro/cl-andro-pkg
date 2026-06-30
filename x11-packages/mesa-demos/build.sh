CLANDRO_PKG_HOMEPAGE=https://www.mesa3d.org
CLANDRO_PKG_DESCRIPTION="OpenGL demonstration and test programs"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.0.0"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://mesa.freedesktop.org/archive/demos/mesa-demos-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=3046a3d26a7b051af7ebdd257a5f23bfeb160cad6ed952329cdff1e9f1ed496b
CLANDRO_PKG_DEPENDS="freeglut, glu, libx11, libxext, opengl"
# will overwrite poly from polyml
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibdrm=disabled
-Dvulkan=disabled
-Dwayland=disabled
-Dwith-system-data-files=true
"

clandro_step_pre_configure() {
	rm -f configure
}

clandro_step_post_make_install() {
	local _system_lib=/system/lib
	if [ $CLANDRO_ARCH_BITS = 64 ]; then
		_system_lib+=64
	fi
	# Use LD_LIBRARY_PATH for eglinfo-system
	local _opt_prefix=$CLANDRO_PREFIX/opt/eglinfo-system
	local _libdir=${_opt_prefix}/lib
	mkdir -p ${_libdir} ${_opt_prefix}/bin
	ln -sf ${_system_lib}/libEGL.so ${_libdir}/libEGL.so
	ln -sf libEGL.so ${_libdir}/libEGL.so.1
	rm -rf ${_opt_prefix}/bin/eglinfo
	cp $CLANDRO_PREFIX/bin/eglinfo ${_opt_prefix}/bin/eglinfo
	local _eglinfo_system_script=${_opt_prefix}/bin/eglinfo-system
	rm -rf ${_eglinfo_system_script}
	cat > ${_eglinfo_system_script} <<-EOF
		#!$CLANDRO_PREFIX/bin/sh
		export LD_LIBRARY_PATH=${_libdir}
		exec ${_opt_prefix}/bin/eglinfo "\$@"
	EOF
	chmod 0700 ${_eglinfo_system_script}
	ln -sf ${_eglinfo_system_script} $CLANDRO_PREFIX/bin/eglinfo-system

	# conflict with polyml package
	mv "$CLANDRO_PREFIX"/bin/poly{,-mesa}
}

clandro_step_install_license() {
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_BUILDER_DIR/LICENSE
}
