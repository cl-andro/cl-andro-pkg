CLANDRO_SUBPKG_INCLUDE="lib/python*"
CLANDRO_SUBPKG_DESCRIPTION="The xcbgen Python module"
# Cannot depend on python due to circular dependency.
CLANDRO_SUBPKG_RECOMMENDS="python"
CLANDRO_SUBPKG_BREAKS="xcb-proto (<< 1.15.2)"
CLANDRO_SUBPKG_REPLACES="xcb-proto (<< 1.15.2)"
