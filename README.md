# google-cloud-cpp
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
