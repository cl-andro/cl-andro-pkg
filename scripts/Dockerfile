# Build with:
#	docker build -t ghcr.io/clandro/package-builder .
# Push to GitHub registry with:
#	docker push ghcr.io/clandro/package-builder
# This is done after changing this file or any of the
# scripts/setup-{ubuntu,android-sdk,cgct}.sh setup scripts.
FROM ubuntu:24.04

# Fix locale to avoid warnings:
ENV LANG=en_US.UTF-8

# Needed for setup:
RUN rm -rf /tmp/clandro-packages
RUN mkdir -p /tmp/clandro-packages
RUN mkdir -p /tmp/clandro-packages/scripts
COPY ./llvm-snapshot.gpg.key ./properties.sh ./setup-android-sdk.sh ./setup-cgct.sh ./setup-ubuntu.sh /tmp/clandro-packages/scripts/
RUN mkdir -p /tmp/clandro-packages/scripts/build
COPY ./build/clandro_download.sh /tmp/clandro-packages/scripts/build/

# Setup needed packages and the Android SDK and NDK and the CGCT:
RUN apt-get update && \
	apt-get -yq upgrade && \
	apt-get install -yq sudo lsb-release software-properties-common && \
	userdel ubuntu && \
	useradd -u 1001 -U -m -s /bin/bash builder && \
	echo "builder ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/builder && \
	chmod 0440 /etc/sudoers.d/builder && \
	chmod a+rx /tmp/clandro-packages/scripts/*.sh /tmp/clandro-packages/scripts/build/clandro_download.sh && \
	su - builder -c "CLANDRO_PKGS__BUILD__IS_DOCKER_BUILD='true' /tmp/clandro-packages/scripts/setup-ubuntu.sh" && \
	su - builder -c "CLANDRO_PKGS__BUILD__IS_DOCKER_BUILD='true' /tmp/clandro-packages/scripts/setup-android-sdk.sh" && \
	# Removed unused parts to make a smaller Docker image:
	apt-get remove -yq --autoremove lsb-release software-properties-common && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	su - builder -c "rm ~/lib/*.zip" && \
	su - builder -c "rm -r ~/.android/cache/"

# Switch User
USER builder:builder

# We expect this to be mounted with '-v $PWD:/home/builder/clandro-packages':
WORKDIR /home/builder/clandro-packages
