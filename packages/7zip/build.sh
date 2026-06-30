CLANDRO_PKG_HOMEPAGE=https://www.7-zip.org
CLANDRO_PKG_DESCRIPTION="7-Zip file archiver with a high compression ratio"
CLANDRO_PKG_LICENSE="LGPL-2.1, BSD 3-Clause, BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="DOC/License.txt, DOC/copying.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.01"
CLANDRO_PKG_SRCURL=(
	"https://www.7-zip.org/a/7z${CLANDRO_PKG_VERSION//./}-src.tar.xz"
	"https://www.7-zip.org/a/7z${CLANDRO_PKG_VERSION//./}-linux-arm.tar.xz" # for manual, arm is smallest
)
CLANDRO_PKG_SHA256=(
	b2389e0e930b2f9a348cf0fe7d9870a46482a8ec044ee0bdf42e2136db31c3d6
	72c19911abb6964fcf85ebe213dfcee57bad892345e03bb940c5a27a1050b3bf
)
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true

# The original "clandro_extract_src_archive" always strips the first components
# but the source of 7zip is directly under the root directory of the tar file
clandro_extract_src_archive() {
	local file="$CLANDRO_PKG_CACHEDIR/$(basename "$CLANDRO_PKG_SRCURL")"
	mkdir -p "$CLANDRO_PKG_SRCDIR"
	tar -xf "$file" -C "$CLANDRO_PKG_SRCDIR"
}

clandro_step_pre_configure() {
	if [ "$CLANDRO_ARCH" = 'aarch64' ]; then
		CFLAGS+=' -march=armv8.1-a+crypto'
		CXXFLAGS+=' -march=armv8.1-a+crypto'
	fi
	# Remove executable perms from docs
	chmod -x DOC/*.txt
	# Remove -Werror to make build succeed
	sed -i -e 's/-Werror//' CPP/7zip/7zip_gcc.mak
}

clandro_step_make() {
	# from https://git.alpinelinux.org/aports/tree/community/7zip/APKBUILD?id=b4601c88f608662c75422311b7ca3c26fab4b1f4
	cd CPP/7zip/Bundles/Alone2
	mkdir -p b/c
	# TODO: enable asm
	# DISABLE_RAR: RAR codec is non-free
	# -D_GNU_SOURCE: broken sched.h defines
	make \
		CC="$CC $CFLAGS $LDFLAGS -D_GNU_SOURCE" \
		CXX="$CXX $CXXFLAGS $LDFLAGS -D_GNU_SOURCE" \
		DISABLE_RAR=1 \
		--file ../../cmpl_clang.mak \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES"
}

clandro_step_make_install() {
	install -Dm0755 \
		-t "$CLANDRO_PREFIX"/bin \
		"$CLANDRO_PKG_BUILDDIR"/CPP/7zip/Bundles/Alone2/b/c/7zz
	install -Dm0644 \
		-t "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME" \
		"$CLANDRO_PKG_BUILDDIR"/DOC/{7zC,7zFormat,copying,License,lzma,Methods,readme,src-history}.txt
	tar -C "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME" \
		-xvf "$CLANDRO_PKG_CACHEDIR/$(basename "${CLANDRO_PKG_SRCURL[1]}")" MANUAL
	# Remove carriage returns from docs
	find "$CLANDRO_PREFIX"/share/doc/"$CLANDRO_PKG_NAME" \
		-type f -execdir sed -i -e 's/\r$//g' {} +
}
