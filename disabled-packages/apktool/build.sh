CLANDRO_PKG_HOMEPAGE=https://ibotpeaches.github.io/Apktool/
CLANDRO_PKG_DESCRIPTION="A tool for reverse engineering 3rd party, closed, binary Android apps"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.6.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/iBotPeaches/Apktool/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8932e77d963b9e0e07227422d82ed4a355e8aa268bad1361e5cfaffa8e4d52ee
CLANDRO_PKG_DEPENDS="aapt, aapt2, openjdk-17"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	local prebuilt_dir="brut.apktool/apktool-lib/src/main/resources/prebuilt"
	rm -rf $prebuilt_dir/{linux,macosx,windows}
	mkdir -p $prebuilt_dir/linux
	for exe_name in aapt aapt2; do
		local exe_path=$prebuilt_dir/linux/${exe_name}
		$CC $CFLAGS $CPPFLAGS aapt-wrapper/${exe_name}-wrapper.c \
			-o ${exe_path} $LDFLAGS
		cp -a ${exe_path} ${exe_path}_64
	done
}

clandro_step_make() {
	sh gradlew build shadowJar -x test
}

clandro_step_make_install() {
	install -Dm600 brut.apktool/apktool-cli/build/libs/apktool-cli-all.jar \
		$CLANDRO_PREFIX/share/java/apktool.jar
	cat <<- EOF > $CLANDRO_PREFIX/bin/apktool
	#!${CLANDRO_PREFIX}/bin/sh
	exec java -jar $CLANDRO_PREFIX/share/java/apktool.jar "\$@"
	EOF
	chmod 700 $CLANDRO_PREFIX/bin/apktool
}
