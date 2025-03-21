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

unzip_ohos_sdk() {
  local platform=$1
  local open_harmony_dir=$2
  echo "platform: ${platform}"
  echo "open_harmony_dir: ${open_harmony_dir}"
  ohos_sdk_zip_dir="${open_harmony_dir}/ohos-sdk/${platform}"
  if [ -d "${ohos_sdk_zip_dir}" ]; then
     echo "Directory '${ohos_sdk_zip_dir}' exist."
     cd "${ohos_sdk_zip_dir}" || exit
     echo "当前目录: $(pwd)"
     zip_files=$(find "${ohos_sdk_zip_dir}" -type f -name "*.zip")
     for zip_file in ${zip_files}
     do
         echo "ohos_sdk_zip_dir_zip_files: ${zip_file}"
         # unzip -o "${zip_file}" -d${ohos_sdk_zip_dir}
     done
  else
     echo "Directory '${ohos_sdk_zip_dir}' does not exist."
  fi
}

checkout() {
    goToWorkSpace
    repo_folder_path="${workspace}/repo/bin"
    if [ ! -d "${repo_folder_path}" ]; then
        mkdir -p "${repo_folder_path}"
        echo "repo_folder_path Folder '${repo_folder_path}' created."
    else
        echo "repo_folder_path Folder '${repo_folder_path}' already exists."
    fi

    repo_file_path="${workspace}/repo/bin/repo"
    if [ -e "$repo_file_path" ]; then
        echo "File '${repo_file_path}' exists."
    else
        echo "File '${repo_file_path}' does not exist."
        curl -o "${workspace}/repo/bin/repo" "https://storage.googleapis.com/git-repo-downloads/repo"
    fi

    goToWorkSpace
    chmod a+x "${workspace}/repo/bin/repo"

    open_harmony_dir="${workspace}/openharmony"
    if [ ! -d "${open_harmony_dir}" ]; then
        mkdir -p "${open_harmony_dir}"
        echo "Directory '${open_harmony_dir}' created."
    else
        echo "Directory '${open_harmony_dir}' already exists."
    fi

    goToOpenHarmonyWorkSpace
    echo "当前目录: $(pwd)"

    # yes | "${repo_file_path}" init -u https://gitee.com/openharmony/manifest.git -b master --no-repo-verify
    # "${repo_file_path}" sync -c
    # "${repo_file_path}" forall -c "git lfs pull"


    ohos_sdk_tar="version-Master_Version-OpenHarmony_4.1.5.2_dev-20231213_020144-ohos-sdk-full.tar.gz"
    ohos_sdk_url="http://download.ci.openharmony.cn/version/Master_Version/OpenHarmony_4.1.5.2_dev/20231213_020144/$ohos_sdk_tar"
    ohos_sdk_dir="${open_harmony_dir}/ohos-sdk"

    if [ ! -f "${ohos_sdk_tar}" ]; then
        wget "${ohos_sdk_url}"
    fi

    if [ -d "${ohos_sdk_dir}" ]; then
        rm -rf "${ohos_sdk_dir}"
    fi

    ohos_sdk_tar_files=$(find "${open_harmony_dir}" -type f -name "*.tar.gz")
    echo "${ohos_sdk_tar_files}"
    for tar_file in ${ohos_sdk_tar_files}
    do
        echo "ohos_sdk_tar_files: ${tar_file}"
        tar -zxvf "${tar_file}"
    done


    unzip_ohos_sdk "linux" "${open_harmony_dir}"
    unzip_ohos_sdk "windows" "${open_harmony_dir}"


    goToWorkSpace
    echo "当前目录: $(pwd)"
}

checkout