#!/bin/bash

echo "> 获得当前目录" $(pwd)
current_platform=$(uname -a | tr '[:upper:]' '[:lower:]')
is_centos=$(echo "$current_platform" | grep -c "centos")
echo "> platform" "$current_platform"
echo "> system" "$(uname -s)"

workspace=$(pwd)
echo "当前目录: ${workspace}"

goToWorkSpace() {
  cd "${workspace}" || exit
}

goToOpenHarmonyWorkSpace() {
    goToWorkSpace
    cd "${workspace}/openharmony" || exit
}

build() {
    goToWorkSpace
    echo "当前目录: $(pwd)"

    goToOpenHarmonyWorkSpace
    echo "当前目录: $(pwd)"
    # ./third_party/skia/auto_build/modify_file_to_build_libskia.sh
    # build/prebuilts_download.sh
    # ./build.sh --product-name rk3568 --build-target skia_canvaskit --no-prebuilt-sdk
}

build