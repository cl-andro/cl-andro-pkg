CLANDRO_PKG_HOMEPAGE=https://umoria.org
CLANDRO_PKG_DESCRIPTION="Rogue-like game with an infinite dungeon"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.7.15
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://github.com/dungeons-of-moria/umoria/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=97f76a68b856dd5df37c20fc57c8a51017147f489e8ee8866e1764778b2e2d57
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-Dbuild_dir=$CLANDRO_PKG_BUILDDIR"
CLANDRO_PKG_GROUPS="games"

clandro_step_create_debscripts() {
	# Create scores file in a debscript, so an update to the package wouldn't erase any scores
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		DIR=$CLANDRO_PREFIX/lib/games/moria
		mkdir -p \$DIR
		touch \$DIR/scores.dat
	EOF

	# https://github.com/termux/termux-packages/issues/1401
	cat <<-EOF > ./prerm
		#!$CLANDRO_PREFIX/bin/sh
		cd $CLANDRO_PREFIX/lib/games/moria || exit
		case \$1 in
			purge|remove)
			rm -f game.sav scores.dat;;
		esac
	EOF
}
