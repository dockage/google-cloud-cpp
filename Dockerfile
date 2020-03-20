FROM ubuntu:eoan

LABEL maintainer="me@mortezana.com" \
	org.label-schema.name="Google Cloud Cpp" \
	org.label-schema.vendor="Dockage" \
	org.label-schema.description="Docker Google-Cloud-Cpp built on Alpine Linux" \
	org.label-schema.license="MIT"

RUN mkdir ~/code/
WORKDIR ~/code

# install required packages
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y build-essential cmake gcc g++ make \
	libc-ares-dev libc-ares2 libcurl4-openssl-dev libssl-dev \
	pkg-config tar wget zlib1g-dev

# -- this part (instructions) completely copies of the google-cloud-cpp documentation
# protobuf
RUN wget -q https://github.com/google/protobuf/archive/v3.11.3.tar.gz && \
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
	cd - && rm -f v3.11.3.tar.gz

# grpc
RUN wget -q https://github.com/grpc/grpc/archive/78ace4cd5dfcc1f2eced44d22d752f103f377e7b.tar.gz && \
	tar -xf 78ace4cd5dfcc1f2eced44d22d752f103f377e7b.tar.gz && \
	cd grpc-78ace4cd5dfcc1f2eced44d22d752f103f377e7b && \
	make -j ${NCPU:-4} && \
	make install && \
	ldconfig && \
	cd - && rm -f 78ace4cd5dfcc1f2eced44d22d752f103f377e7b.tar.gz

# crc32c
RUN wget -q https://github.com/google/crc32c/archive/1.0.6.tar.gz && \
	tar -xf 1.0.6.tar.gz && \
	cd crc32c-1.0.6 && \
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
	cd - && rm -f 1.0.6.tar.gz

# googleapis
RUN wget -q https://github.com/googleapis/cpp-cmakefiles/archive/v0.4.1.tar.gz && \
	tar -xf v0.4.1.tar.gz && \
	cd cpp-cmakefiles-0.4.1 && \
	cmake -DBUILD_SHARED_LIBS=YES -H. -Bcmake-out && \
	cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd - && rm -f v0.4.1.tar.gz

# googletest
RUN wget -q https://github.com/google/googletest/archive/release-1.10.0.tar.gz && \
	tar -xf release-1.10.0.tar.gz && \
	cd googletest-release-1.10.0 && \
	cmake -DCMAKE_BUILD_TYPE="Release" -DBUILD_SHARED_LIBS=yes -H. -Bcmake-out && \
	cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd - && rm -f release-1.10.0.tar.gz

# google cloud cpp common
RUN wget -q https://github.com/googleapis/google-cloud-cpp-common/archive/v0.20.0.tar.gz && \
	tar -xf v0.20.0.tar.gz && \
	cd google-cloud-cpp-common-0.20.0 && \
	cmake -H. -Bcmake-out \
	-DBUILD_TESTING=OFF \
	-DGOOGLE_CLOUD_CPP_TESTING_UTIL_ENABLE_INSTALL=ON && \
	cmake --build cmake-out -- -j ${NCPU:-4} && \
	cmake --build cmake-out --target install -- -j ${NCPU:-4} && \
	ldconfig && \
	cd - && rm -f v0.20.0.tar.gz

# google cloud cpp (main)
RUN wget -q https://github.com/googleapis/google-cloud-cpp/archive/v0.20.0.tar.gz && \
	tar -xf v0.20.0.tar.gz && \
	ls -lha && \
	cd google-cloud-cpp-0.20.0 && \
	cmake -H. -Bcmake-out && \
	cmake --build cmake-out -- -j "${NCPU:-4}" && \
	cd cmake-out && \
	ctest -LE integration-tests --output-on-failure && \
	cmake --build . --target install && \
	ldconfig
