CLANDRO_PKG_HOMEPAGE=https://github.com/mjuhasz/BDSup2Sub
CLANDRO_PKG_DESCRIPTION="A subtitle conversion tool for image based stream formats"
CLANDRO_PKG_LICENSE="Apache-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mjuhasz/BDSup2Sub/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8ad9529e58d2eeadb5c2be80bfcdaaa06a8714c3144c327491c1d19431993ad9
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="openjdk-21"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	cp -T $CLANDRO_PKG_BUILDER_DIR/src-Manifest.txt src/Manifest.txt
}

clandro_step_pre_configure() {
	_BUILD_JARFILE="$CLANDRO_PKG_BUILDDIR/${CLANDRO_PKG_NAME}.jar"
}

clandro_step_make() {
	cd src
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name "*.java")
	rm -f "${_BUILD_JARFILE}"
	jar cfm "${_BUILD_JARFILE}" Manifest.txt $(find . -name "*.class")
}

clandro_step_make_install() {
	local _JAR_DIR=$CLANDRO_PREFIX/share/java
	install -Dm600 -t ${_JAR_DIR} "${_BUILD_JARFILE}"

	local exe=$CLANDRO_PREFIX/bin/bdsup2sub
	mkdir -p $(dirname ${exe})
	rm -f ${exe}
	cat <<-EOF > ${exe}
		#!$CLANDRO_PREFIX/bin/sh
		exec java -jar ${_JAR_DIR}/$(basename "${_BUILD_JARFILE}") "\$@"
	EOF
	chmod 0700 ${exe}
}
