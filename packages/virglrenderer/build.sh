CLANDRO_PKG_HOMEPAGE=https://virgil3d.github.io/
CLANDRO_PKG_DESCRIPTION="A virtual 3D GPU for use inside qemu virtual machines"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.0"
CLANDRO_PKG_SRCURL=https://gitlab.freedesktop.org/virgl/virglrenderer/-/archive/virglrenderer-${CLANDRO_PKG_VERSION}/virglrenderer-virglrenderer-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=56170f8caa1bb642a2624b649e3bcca095ec2834814e5c308efc8a85a709e4ce
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libdrm, libepoxy, libglvnd, libx11, mesa"
CLANDRO_PKG_BUILD_DEPENDS="xorgproto"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dplatforms=egl,glx"

clandro_step_pre_configure() {
	# error: using an array subscript expression within 'offsetof' is a Clang extension [-Werror,-Wgnu-offsetof-extensions]
	# list_for_each_entry_safe(struct vrend_linked_shader_program, ent, &shader->programs, sl[shader->sel->type])
	CPPFLAGS+=" -Wno-error=gnu-offsetof-extensions"

	if [[ $CLANDRO_ARCH != "arm" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -Dvenus=true"
	fi
}
