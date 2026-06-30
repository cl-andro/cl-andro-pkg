CLANDRO_PKG_HOMEPAGE=https://developer.android.com/studio/command-line/d8
CLANDRO_PKG_DESCRIPTION="DEX bytecode compiler from Android SDK"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Do not use the CLANDRO_ANDROID_BUILD_TOOLS_VERSION variable when specifying:
CLANDRO_PKG_VERSION=33.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED=true

clandro_step_pre_configure() {
	# Version guard
	if [ "${CLANDRO_PKG_VERSION#*:}" != "${CLANDRO_ANDROID_BUILD_TOOLS_VERSION}" ]; then
		clandro_error_exit "Version mismatch between CLANDRO_PKG_VERSION and CLANDRO_ANDROID_BUILD_TOOLS_VERSION."
	fi
}

clandro_step_make_install() {
	install -Dm600 $ANDROID_HOME/build-tools/${CLANDRO_ANDROID_BUILD_TOOLS_VERSION}/lib/d8.jar \
		$CLANDRO_PREFIX/share/java/d8.jar

	cat <<- EOF > $CLANDRO_PREFIX/bin/d8
	#!${CLANDRO_PREFIX}/bin/sh
	exec java -cp $CLANDRO_PREFIX/share/java/d8.jar com.android.tools.r8.D8 "\$@"
	EOF

	cat <<- EOF > $CLANDRO_PREFIX/bin/r8
	#!${CLANDRO_PREFIX}/bin/sh
	exec java -cp $CLANDRO_PREFIX/share/java/d8.jar com.android.tools.r8.R8 "\$@"
	EOF

	chmod 700 $CLANDRO_PREFIX/bin/d8 $CLANDRO_PREFIX/bin/r8
}
