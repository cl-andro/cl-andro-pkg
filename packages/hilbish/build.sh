CLANDRO_PKG_HOMEPAGE=https://rosettea.github.io/Hilbish/
CLANDRO_PKG_DESCRIPTION="The Moon-powered shell! A comfy and extensible shell for Lua fans!"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=(
	"1:2.3.4" # hilbish
	"3.1.2"   # inspect.lua (Lua dependency)
	"0.2.1"   # lunacolors (Lua dependency)
	"0.1.0"   # succulent (Lua dependency)
)
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_REPOLOGY_METADATA_VERSION="${CLANDRO_PKG_VERSION[0]:2}"
CLANDRO_PKG_SRCURL=(
	"https://github.com/Rosettea/Hilbish/archive/refs/tags/v${CLANDRO_PKG_VERSION[0]:2}.tar.gz"
	"https://github.com/kikito/inspect.lua/archive/refs/tags/v${CLANDRO_PKG_VERSION[1]}.tar.gz"
	"https://github.com/Rosettea/Lunacolors/archive/refs/tags/v${CLANDRO_PKG_VERSION[2]}.tar.gz"
	"https://github.com/Rosettea/Succulent/archive/refs/tags/v${CLANDRO_PKG_VERSION[3]}.tar.gz"
)
CLANDRO_PKG_SHA256=(
	747f509bf8091cd0decb631c0402e6caeb6ba82f35328d2125ae730b332ea0fc
	6b5856d04bc9ab12a5849dd529bb5f6a986a8cb7447f8824479aedbaca259622
	6cc64419c5783d8f91589f69353deec5160d5a6f606f4bbc6258492cc2717642
	a76aa3050bfc03b728c9181eb26ca84c19b2ff6a75facdb10a184dea4c6a97e2
)
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	rm -vrf libs/{inspect,lunacolors,succulent}
	mv "inspect.lua-${CLANDRO_PKG_VERSION[1]}" libs/inspect
	mv "Lunacolors-${CLANDRO_PKG_VERSION[2]}" libs/lunacolors
	mv "Succulent-${CLANDRO_PKG_VERSION[3]}" libs/succulent
}

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_SRCDIR
	LDFLAGS=" -checklinkname=0"
	LDFLAGS+=" -s -w"
	LDFLAGS+=" -X main.gitCommit=$(git ls-remote https://github.com/Rosettea/Hilbish "refs/tags/v${CLANDRO_PKG_VERSION[0]:2}" | cut -f1)"
	LDFLAGS+=" -X main.releaseName=${CLANDRO_PKG_VERSION[0]:2}"

	GOOS=android CGO_ENABLED=1 go build -ldflags "${LDFLAGS}"
}

clandro_step_make_install() {
	mkdir -p "$CLANDRO_PREFIX/share/hilbish"
	install -Dm 0700 hilbish "$CLANDRO_PREFIX/bin/hilbish"
	cp -r libs docs emmyLuaDocs nature .hilbishrc.lua "$CLANDRO_PREFIX/share/hilbish"
}
