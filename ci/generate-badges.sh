#!/usr/bin/env bash
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

set -eu

# Use this script to generate the badges in the README.md file.

BINDIR="$(dirname "$0")"
readonly BINDIR

echo
echo '**Core Builds**'
find "${BINDIR}/kokoro/macos" "${BINDIR}/kokoro/docker" \
    \( -name '*-presubmit.cfg' -o -name 'common.cfg' \) -prune \
    -o -name '*.cfg' -print0 |
  while IFS= read -r -d $'\0' file; do
    base="$(basename "${file}" .cfg)"
    dir="$(dirname "${file}")"
    prefix="$(basename "${dir}")"
    echo "[![CI status ${prefix}/${base}][${prefix}/${base}-shield]][${prefix}/${base}-link]"
  done |
  sort

cat <<'_EOF_'
[![CI status windows/bazel][windows/bazel-shield]][windows/bazel-link]
[![CI status windows/cmake][windows/cmake-shield]][windows/cmake-link]
[![Code Coverage Status][codecov-io-badge]][codecov-io-link]
[![Link to Reference Documentation][doxygen-shield]][doxygen-link]

<!-- TODO(#40) - configure and enable ci/kokoro/install/* builds -->

_EOF_

# TODO(#40) - configure and enable ci/kokoro/install/* builds
#find "${BINDIR}/kokoro/install" \
#    \( -name '*-presubmit.cfg' -o -name 'common.cfg' \) -prune \
#    -o -name '*.cfg' -print0 |
#  while IFS= read -r -d $'\0' file; do
#    base="$(basename "${file}" .cfg)"
#    dir="$(dirname "${file}")"
#    prefix="$(basename "${dir}")"
#    echo "[![CI status ${prefix}/${base}][${prefix}/${base}-shield]][${prefix}/${base}-link]"
#  done |
#  sort
#

# We need at least one blank line before the link definitions.
echo
find "${BINDIR}/kokoro/macos" "${BINDIR}/kokoro/docker" "${BINDIR}/kokoro/install" \
    \( -name '*-presubmit.cfg' -o -name 'common.cfg' \) -prune \
    -o -name '*.cfg' -print0 |
  while IFS= read -r -d $'\0' file; do
    base="$(basename "${file}" .cfg)"
    dir="$(dirname "${file}")"
    prefix="$(basename "${dir}")"
    echo "[${prefix}/${base}-shield]: https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/${prefix}/${base}.svg"
    echo "[${prefix}/${base}-link]: https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/${prefix}/${base}-link.html"
  done |
  sort

cat <<'_EOF_'
[codecov-io-badge]: https://codecov.io/gh/googleapis/google-cloud-cpp-pubsub/branch/master/graph/badge.svg
[codecov-io-link]: https://codecov.io/gh/googleapis/google-cloud-cpp-pubsub
[doxygen-shield]: https://img.shields.io/badge/documentation-master-brightgreen.svg
[doxygen-link]: https://googleapis.dev/cpp/google-cloud-pubsub/latest/
[windows/bazel-shield]: https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/windows/bazel.svg
[windows/bazel-link]:   https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/windows/bazel-link.html
[windows/cmake-shield]: https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/windows/cmake.svg
[windows/cmake-link]:   https://storage.googleapis.com/cloud-cpp-kokoro-status/pubsub/windows/cmake-link.html
_EOF_

exit 0
