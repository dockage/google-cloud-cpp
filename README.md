# google-cloud-cpp [![Docker Pulls](https://img.shields.io/docker/pulls/dockage/google-cloud-cpp.svg?style=flat)](https://hub.docker.com/r/dockage/google-cloud-cpp/) [![Docker Stars](https://img.shields.io/docker/stars/dockage/google-cloud-cpp.svg?style=flat)](https://hub.docker.com/r/dockage/google-cloud-cpp/) [![MicroBadger Size (latest)](https://img.shields.io/microbadger/image-size/dockage/google-cloud-cpp/latest.svg)](https://microbadger.com/images/dockage/google-cloud-cpp:latest) [![MicroBadger Layers (latest)](https://img.shields.io/microbadger/layers/dockage/google-cloud-cpp/latest.svg)](https://microbadger.com/images/dockage/google-cloud-cpp:latest) [![Build Status](https://cloud.drone.io/api/badges/dockage/google-cloud-cpp/status.svg)](https://cloud.drone.io/dockage/google-cloud-cpp)
Google cloud cpp docker image. List of supported cpp libraries:

* BigQuery
* BigTable
* Spanner
* Pub/Sub
* Storage

To know about the [google-could-cpp](https://github.com/googleapis/google-cloud-cpp) please, read the [official](https://github.com/googleapis/google-cloud-cpp) document.

## Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. These builds are performed by the **Docker Trusted Build** service.

```bash
$ docker pull dockage/google-cloud-cpp:latest
```

Alternatively, you can build the image locally.

```bash
$ git clone https://github.com/dockage/google-cloud-cpp.git
$ cd google-cloud-cpp
$ docker build --tag="$USER/google-cloud-cpp" -f v1.20/ubuntu/20.04/Dockerfile .
```

## Quickstart

This part got a copy of [official documentation of the google-cloud-cpp installation page](https://github.com/googleapis/google-cloud-cpp-common/blob/master/INSTALL.md).

It depends on your building process tools, these flags are required in your C++ projects:

* `pkg-config storage_client --cflags`
* `pkg-config storage_client --libs-only-L`
* `pkg-config storage_client --libs-only-l`
* `pkg-config bigtable_client --cflags`
* `pkg-config bigtable_client --libs-only-L`
* `pkg-config bigtable_client --libs-only-l`

Command:

```bash
$ g++ my_program.cc -o my_program `pkg-config storage_client --cflags` `pkg-config storage_client --libs-only-L` `pkg-config storage_client --libs-only-l`
```

In CMake ([document link](https://github.com/googleapis/google-cloud-cpp-common/blob/master/INSTALL.md#using-google-cloud-cpp-common-in-cmake-based-projects)):

```cmake
cmake_minimum_required(VERSION 3.5)

find_package(google_cloud_cpp_common REQUIRED)

add_executable(my_program my_program.cc)
target_link_libraries(my_program google_cloud_cpp_common)
```

Makefile ([document link](https://github.com/googleapis/google-cloud-cpp-common/blob/master/INSTALL.md#using-google-cloud-cpp-common-in-make-based-projects)):

```makefile
GCS_CXXFLAGS   := $(shell pkg-config storage_client --cflags)
GCS_CXXLDFLAGS := $(shell pkg-config storage_client --libs-only-L)
GCS_LIBS       := $(shell pkg-config storage_client --libs-only-l)

my_storage_program: my_storage_program.cc
        $(CXX) $(CXXFLAGS) $(GCS_CXXFLAGS) $(GCS_CXXLDFLAGS) -o $@ $^ $(GCS_LIBS)

CBT_CXXFLAGS   := $(shell pkg-config bigtable_client --cflags)
CBT_CXXLDFLAGS := $(shell pkg-config bigtable_client --libs-only-L)
CBT_LIBS       := $(shell pkg-config bigtable_client --libs-only-l)

my_bigtable_program: my_bigtable_program.cc
        $(CXX) $(CXXFLAGS) $(CBT_CXXFLAGS) $(CBT_CXXLDFLAGS) -o $@ $^ $(CBT_LIBS)
```

You can also build your project outside, and then put the compiled file inside the container. Then you don't need to install the related tools anymore.

## Issues

Before reporting your issue please try updating Docker to the latest version and check if it resolves the issue. Refer to the Docker [installation guide](https://docs.docker.com/installation) for instructions.

If the above recommendations do not help then [report your issue](../../issues/new) along with the following information:

- Output of the `docker vers6` and `docker info` commands.
- The `docker run` command or `docker-compose.yml` used to start the image. Mask out the sensitive bits.
- Please state if you are using [Boot2Docker](http://www.boot2docker.io), [VirtualBox](https://www.virtualbox.org), etc.
