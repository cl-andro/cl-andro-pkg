#!@CLANDRO_PREFIX@/bin/sh
case "$1" in
purge|remove)
rm -fr "@CLANDRO_PREFIX@/opt/emscripten"
esac
