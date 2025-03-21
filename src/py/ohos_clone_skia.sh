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

goToSkiaWorkSpace() {
  cd "${workspace}/skia" || exit
}

clone() {
    goToWorkSpace
    echo "当前目录: $(pwd)"
    goToSkiaWorkSpace
    echo "Skia目录: $(pwd)"
    goToWorkSpace
    # 克隆或更新Skia仓库
    if [ -d "skia" ]; then
      echo "> Fetching"
      cd "skia" || exit
      git reset --hard
      git clean -d -f
      git fetch origin
    else
      echo "> Cloning"
      git clone https://skia.googlesource.com/skia
      cd "skia" || exit
      git fetch origin
    fi

    # 切换到指定commit
    echo "> Checking out $commit"
    # git -c advice.detachedHead=false checkout $commit


    # 更新git依赖
    echo "> Running tools/git-sync-deps"
    if [ "$(uname)" == "MINGW64_NT-10.0" ]; then
      # python3 tools/git-sync-deps
      echo "> tools/git-sync-deps"
    else
      # python3 tools/git-sync-deps
      echo "> tools/git-sync-deps"
    fi
}

clone