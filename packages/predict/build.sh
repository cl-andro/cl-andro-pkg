CLANDRO_PKG_HOMEPAGE=https://www.qsl.net/kd2bd/predict.html
CLANDRO_PKG_DESCRIPTION="A Satellite Tracking/Orbital Prediction Program"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.3.1
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://www.qsl.net/kd2bd/predict-${CLANDRO_PKG_VERSION}-termux.tar.gz
CLANDRO_PKG_SHA256=6eecccb21117e6ae57941659ac5d1d5f8cf99103ec8448e4fd8c076620bbd77b
CLANDRO_PKG_DEPENDS="ncurses, ncurses-ui-libs,play-audio,wget"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	rm "${CLANDRO_PKG_SRCDIR}/configure"
}

# shellcheck disable=SC2086 # We actually want word splitting on those variables
clandro_step_make() {
	echo "char *predictpath={\"$CLANDRO_PREFIX/opt/predict/\"}, soundcard=1, *version={\"$(cat .version)\"};" > predict.h
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -Wall -Wno-deprecated-non-prototype predict.c -lm -lncurses -o predict
}

clandro_step_make_install() {
	mkdir -p "$CLANDRO_PREFIX"/opt/predict

	install -Dm700 predict "$CLANDRO_PREFIX"/opt/predict/predict
	install -Dm700 kepupdate "$CLANDRO_PREFIX"/opt/predict/kepupdate
	cp -r ./default "$CLANDRO_PREFIX"/opt/predict/
	cp -r ./vocalizer "$CLANDRO_PREFIX"/opt/predict/

	gzip -c "$PWD"/docs/man/predict.1 > "$CLANDRO_PREFIX"/share/man/man1/predict.1.gz

	ln -sfr "$CLANDRO_PREFIX"/opt/predict/predict "$CLANDRO_PREFIX"/bin/predict
	ln -sfr "$CLANDRO_PREFIX"/opt/predict/kepupdate "$CLANDRO_PREFIX"/bin/kepupdate
}
