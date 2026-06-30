CLANDRO_PKG_HOMEPAGE=https://groovy-lang.org/
CLANDRO_PKG_DESCRIPTION="A powerful multi-faceted programming language for the JVM platform"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.26"
CLANDRO_PKG_REVISION=4
_JANSI_VERSION=2.4.1
_JLINE_VERSION=2.14.6
_JANSI_TAGNAME="jansi-${_JANSI_VERSION}"
_JLINE2_TAGNAME="jline-${_JLINE_VERSION}"
CLANDRO_PKG_SRCURL=(https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-$CLANDRO_PKG_VERSION.zip
                   https://github.com/fusesource/jansi/archive/refs/tags/${_JANSI_TAGNAME}.tar.gz
                   https://github.com/jline/jline2/archive/refs/tags/${_JLINE2_TAGNAME}.tar.gz)
CLANDRO_PKG_SHA256=(3be6880c6de70eada2f3f5c69e1e94953e0b0c4e33c4604c1040d05dddeaed92
                   d992c07f17fc2937f7ef0579c6386457a476ef93b1e81778b427c09318a70833
                   c6205afb214288cd8ef53f1ea1243ba9388c84b55c929f0b9e6cee7757c6efac)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libjansi (>= 2.4.0-1), openjdk-21"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_post_get_source() {
	mv jansi-${_JANSI_TAGNAME} jansi
	cp "$CLANDRO_PKG_BUILDER_DIR"/AnsiRenderWriter.java \
		jansi/src/main/java/org/fusesource/jansi/

	mv jline2-${_JLINE2_TAGNAME} jline2
	rm -f jline2/src/main/java/jline/{Ansi,}WindowsTerminal.java
}

clandro_step_make() {
	rm -f ./bin/*.bat

	mkdir -p lib/jansi-native
	ln -sf $CLANDRO_PREFIX/lib/jansi/libjansi.so lib/jansi-native/

	local _JANSI_JARFILE="$CLANDRO_PKG_BUILDDIR"/lib/${_JANSI_TAGNAME}.jar
	rm "${_JANSI_JARFILE}"
	cd "$CLANDRO_PKG_BUILDDIR"/jansi/src/main/java
	javac -encoding UTF-8 -source 1.8 -target 1.8 $(find . -name '*.java')
	jar cf "${_JANSI_JARFILE}" $(find . -name '*.class')

	local _JLINE_JARFILE="$CLANDRO_PKG_BUILDDIR"/lib/${_JLINE2_TAGNAME}.jar
	rm "${_JLINE_JARFILE}"
	cd "$CLANDRO_PKG_BUILDDIR"/jline2/src/main/java
	javac -cp "${_JANSI_JARFILE}" -encoding UTF-8 -source 1.8 -target 1.8 \
		$(find . -name '*.java')
	jar cf "${_JLINE_JARFILE}" $(find . -name '*.class')
	cd "$CLANDRO_PKG_BUILDDIR"/jline2/src/main/resources
	jar uf "${_JLINE_JARFILE}" $(find . -name '*.properties')
}

clandro_step_make_install() {
	rm -rf $CLANDRO_PREFIX/opt/groovy
	mkdir -p $CLANDRO_PREFIX/opt/groovy
	find . -mindepth 1 -maxdepth 1 ! -name jansi ! -name jline2 \
			-exec cp -r \{\} $CLANDRO_PREFIX/opt/groovy/ \;
	for i in $CLANDRO_PREFIX/opt/groovy/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr $i $CLANDRO_PREFIX/bin/$(basename $i)
	done
}
