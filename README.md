# google-cloud-cpp [![Docker Pulls](https://img.shields.io/docker/pulls/dockage/google-cloud-cpp.svg?style=flat)](https://hub.docker.com/r/dockage/google-cloud-cpp/) [![Docker Stars](https://img.shields.io/docker/stars/dockage/google-cloud-cpp.svg?style=flat)](https://hub.docker.com/r/dockage/google-cloud-cpp/) [![MicroBadger Size (latest)](https://img.shields.io/microbadger/image-size/dockage/google-cloud-cpp/latest.svg)](https://microbadger.com/images/dockage/google-cloud-cpp:latest) [![MicroBadger Layers (latest)](https://img.shields.io/microbadger/layers/dockage/google-cloud-cpp/latest.svg)](https://microbadger.com/images/dockage/google-cloud-cpp:latest) [![Build Status](https://cloud.drone.io/api/badges/dockage/google-cloud-cpp/status.svg)](https://cloud.drone.io/dockage/google-cloud-cpp)
Google Cloud Cpp Docker Image

## UNDER THE DEVELOPMENT ##

# Build

# Quick Start

It depends on your build process tools, for CMake please have a look into:

How to compile a sample C++ source code:

Command's options got copy from https://github.com/googleapis/google-cloud-cpp-common/blob/master/INSTALL.md#using-google-cloud-cpp-common-in-make-based-projects
```
g++ mycode.cc `pkg-config storage_client --cflags` `pkg-config storage_client --libs-only-L` `pkg-config storage_client --libs-only-l`
```
