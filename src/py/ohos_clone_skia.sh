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

clone() {
    goToWorkSpace
    echo "当前目录: $(pwd)"
    # 克隆或更新Skia仓库
    if [ -d "skia" ]; then
      echo "> Fetching"
      cd "skia"
      git reset --hard
      git clean -d -f
      git fetch origin
    else
      echo "> Cloning"
      git clone https://github.com/JetBrains/skia.git
      cd "skia"
      git fetch origin
    fi
}

clone