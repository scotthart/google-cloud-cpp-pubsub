# ~~~
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ~~~

cmake_minimum_required(VERSION 3.5)
project(google-cloud-cpp-pubsub CXX C)

set(GOOGLE_CLOUD_CPP_CXX_STANDARD
    11
    CACHE STRING "Configure CMAKE_CXX_STANDARD")
mark_as_advanced(GOOGLE_CLOUD_CPP_CXX_STANDARD)

set(CMAKE_CXX_STANDARD "${GOOGLE_CLOUD_CPP_CXX_STANDARD}")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# If possible, enable a code coverage build type.
include(EnableCoverage)
include(SelectMSVCRuntime)

# C++ Exceptions are enabled by default, but allow the user to turn them off.
include(EnableCxxExceptions)

# This should be included from the top level CMakeLists file
set(GOOGLE_CLOUD_CPP_CLIENT_VERSION_MAJOR 0)
set(GOOGLE_CLOUD_CPP_CLIENT_VERSION_MINOR 1)
set(GOOGLE_CLOUD_CPP_CLIENT_VERSION_PATCH 0)
string(
    CONCAT GOOGLE_CLOUD_CPP_CLIENT_VERSION
           "${GOOGLE_CLOUD_CPP_CLIENT_VERSION_MAJOR}"
           "."
           "${GOOGLE_CLOUD_CPP_CLIENT_VERSION_MINOR}"
           "."
           "${GOOGLE_CLOUD_CPP_CLIENT_VERSION_PATCH}")

include(CTest)

add_subdirectory(google/cloud/pubsub)
