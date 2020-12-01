FROM ubuntu:20.04

LABEL maintainer="m@0t1.me" \
	org.label-schema.name="Google Cloud Cpp" \
	org.label-schema.vendor="Dockage" \
	org.label-schema.description="Docker Google-Cloud-Cpp built on Ubuntu Linux" \
	org.label-schema.license="MIT"

RUN mkdir /code/
WORKDIR /code

# install required packages
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get --no-install-recommends install -y apt-transport-https apt-utils \
        automake build-essential ccache cmake ca-certificates git gcc g++ \
        libc-ares-dev libc-ares2 libcurl4-openssl-dev libssl-dev m4 make \
        pkg-config tar wget zlib1g-dev

# -- this part (instructions) completely copies of the google-cloud-cpp documentation
RUN wget -q https://github.com/abseil/abseil-cpp/archive/20200225.2.tar.gz && \
    tar -xf 20200225.2.tar.gz && \
    cd abseil-cpp-20200225.2 && \
    sed -i 's/^#define ABSL_OPTION_USE_\(.*\) 2/#define ABSL_OPTION_USE_\1 0/' "absl/base/options.h" && \
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING=OFF \
      -DBUILD_SHARED_LIBS=yes \
      -DCMAKE_CXX_STANDARD=11 \
      -H. -Bcmake-out && \
    cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd /code && rm -rf 20200225.2.tar.gz abseil-cpp-20200225.2 && \
	wget -q https://github.com/google/protobuf/archive/v3.11.3.tar.gz && \
    tar -xf v3.11.3.tar.gz && \
    cd protobuf-3.11.3/cmake && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
        -Dprotobuf_BUILD_TESTS=OFF \
        -H. -Bcmake-out && \
    cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd /code && rm -rf v3.11.3.tar.gz protobuf-3.11.3 && \
	wget -q https://github.com/grpc/grpc/archive/v1.29.1.tar.gz && \
    tar -xf v1.29.1.tar.gz && \
    cd grpc-1.29.1 && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DgRPC_ABSL_PROVIDER=package \
        -DgRPC_CARES_PROVIDER=package \
        -DgRPC_PROTOBUF_PROVIDER=package \
        -DgRPC_SSL_PROVIDER=package \
        -DgRPC_ZLIB_PROVIDER=package \
        -H. -Bcmake-out && \
    cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd /code && rm -rf v1.29.1.tar.gz grpc-1.29.1 && \
	wget -q https://github.com/google/crc32c/archive/1.1.0.tar.gz && \
    tar -xf 1.1.0.tar.gz && \
    cd crc32c-1.1.0 && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=yes \
        -DCRC32C_BUILD_TESTS=OFF \
        -DCRC32C_BUILD_BENCHMARKS=OFF \
        -DCRC32C_USE_GLOG=OFF \
        -H. -Bcmake-out && \
    cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd /code && rm -rf 1.1.0.tar.gz crc32c-1.1.0 && \
	wget -q https://github.com/nlohmann/json/archive/v3.9.0.tar.gz && \
    tar -xzf v3.9.0.tar.gz && \
    cd json-3.9.0 && \
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=yes \
      -DBUILD_TESTING=OFF \
      -H. -Bcmake-out/nlohmann/json && \
	cmake --build cmake-out/nlohmann/json --target install -- -j ${NCPU} && \
	ldconfig && \
	cd /code && rm -rf v3.9.0.tar.gz json-3.9.0 && \
	wget -q https://github.com/googleapis/google-cloud-cpp/archive/v1.21.0.tar.gz && \
	tar -xf v1.21.0.tar.gz && \
	ls -lha && \
	cd google-cloud-cpp-1.21.0 && \
	cmake -DBUILD_TESTING=OFF -H. -Bcmake-out && \
	cmake --build cmake-out -- -j "${NCPU:-4}" && \
	cmake --build cmake-out --target install && \
	ldconfig && \
	cd /code && rm -rf v1.21.0.tar.gz google-cloud-cpp-1.21.0
