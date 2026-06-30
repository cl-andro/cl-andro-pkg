CLANDRO_PKG_HOMEPAGE="https://github.com/kubernetes/minikube"
CLANDRO_PKG_DESCRIPTION="minikube implements a local Kubernetes cluster."
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.38.1"
CLANDRO_PKG_SRCURL="https://github.com/kubernetes/minikube/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f3401ff708235441d12ee47f5e8b5e7f55e7944585ae2a9bdb4b8cb629838f7c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="docker, kubectl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	mkdir -p bin
	go build -o bin/minikube ./cmd/minikube
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}"/bin bin/minikube
}
