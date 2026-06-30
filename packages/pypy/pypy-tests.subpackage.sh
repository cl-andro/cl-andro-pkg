CLANDRO_SUBPKG_DESCRIPTION="Test files for PyPy"
CLANDRO_SUBPKG_INCLUDE="
opt/pypy/lib-python/${_MAJOR_VERSION}/test
opt/pypy/lib-python/${_MAJOR_VERSION}/*/test
opt/pypy/lib-python/${_MAJOR_VERSION}/*/tests
"

clandro_step_create_subpkg_debscripts() {
	# Pre-rm script to cleanup runtime-generated files.
	cat <<- PRERM_EOF > ./prerm
	#!$CLANDRO_PREFIX/bin/sh

	if [ "$CLANDRO_PACKAGE_FORMAT" != "pacman" ] && [ "\$1" != "remove" ]; then
	    exit 0
	fi

	echo "Deleting *.pyc..."
	find $CLANDRO_PREFIX/opt/pypy/lib-python | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

	exit 0
	PRERM_EOF

	chmod 0755 prerm
}
