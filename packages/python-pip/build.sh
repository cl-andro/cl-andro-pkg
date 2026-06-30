CLANDRO_PKG_HOMEPAGE=https://pip.pypa.io/
CLANDRO_PKG_DESCRIPTION="The PyPA recommended tool for installing Python packages"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.1.1"
CLANDRO_PKG_SRCURL=https://github.com/pypa/pip/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f146fc3ad7e51cb3f13accc166fbcfa2f2b3bab377bf9433648efe765f9f62c0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_UPDATE_VERSION_REGEXP='\d+(?:\.\d+){1,2}(?!b)' # matches '25.3', '25.3.1' but not '26.0b1'
CLANDRO_PKG_DEPENDS="python (>= 3.11.1-1)"
CLANDRO_PKG_RECOMMENDS="clang, make, pkg-config"
CLANDRO_PKG_BREAKS="python (<< 3.11.1-1)"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_PYTHON_COMMON_BUILD_DEPS="docutils, myst_parser, sphinx_copybutton, sphinx_inline_tabs, sphinxcontrib.towncrier, completion"

clandro_step_post_make_install() {
	if [ ! -e "$CLANDRO_PYTHON_HOME/site-packages/pip-$CLANDRO_PKG_VERSION.dist-info" ]; then
		clandro_error_exit "Package ${CLANDRO_PKG_NAME} doesn't build properly."
	fi
	( # creating pip documentation
		cd docs/
		python pip_sphinxext.py
		sphinx-build -b man -d build/doctrees/man man build/man -c html --tag man
	)

	install -vDm 644 LICENSE.txt -t "$CLANDRO_PREFIX/share/licenses/python-pip/"
	install -vDm 644 docs/build/man/*.1 -t "$CLANDRO_PREFIX/share/man/man1/"
	install -vDm 644 {NEWS,README}.rst -t "$CLANDRO_PREFIX/share/doc/python-pip/"

	"$CLANDRO_PREFIX"/bin/pip completion --bash | install -vDm 644 /dev/stdin "$CLANDRO_PREFIX"/share/bash-completion/completions/pip
	"$CLANDRO_PREFIX"/bin/pip completion --fish | install -vDm 644 /dev/stdin "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/pip.fish
}

clandro_step_create_debscripts() {
	# disable pip update notification
	cat <<- POSTINST_EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/bash
	echo "pip setup..."
	pip config set --global global.disable-pip-version-check true
	exit 0
	POSTINST_EOF
	if [ "$CLANDRO_PACKAGE_FORMAT" = "pacman" ]; then
		echo "post_install" > postupg
	fi

	# deleting conf of pip while removing it
	cat <<- PRERM_EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/bash
	if [ -d $CLANDRO_PREFIX/etc/pip.conf ]; then
		echo "Removing the pip setting..."
		rm -fr $CLANDRO_PREFIX/etc/pip.conf
	fi
	exit 0
	PRERM_EOF

	chmod 0755 postinst prerm
}
