BUILD.gn
```
public_deps = [
      "//third_party/jsoncpp",
]
```

DEPS
```
 "third_party/externals/jsoncpp"       : "https://chromium.googlesource.com/external/github.com/open-source-parsers/jsoncpp.git@1.0.0",
```

third_party/jsoncpp
```
# Copyright 2016 Google Inc.
#
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

declare_args() {
  skia_use_system_jsoncpp = is_official_build
}

import("../third_party.gni")

if (skia_use_system_jsoncpp) {
  system("jsoncpp") {
    libs = [ "jsoncpp" ]
  }
} else {
  third_party("jsoncpp") {
    public_include_dirs = [ "../externals/jsoncpp/include" ]

    defines = [ "JSON_USE_EXCEPTION=0" ]
    sources = [
      "../externals/jsoncpp/src/lib_json/json_reader.cpp",
      "../externals/jsoncpp/src/lib_json/json_value.cpp",
      "../externals/jsoncpp/src/lib_json/json_writer.cpp",
    ]
    testonly = true
  }
}
```
https://chromium.googlesource.com/chromium/src/third_party/jsoncpp/+/fd0ac8ce63a47e99b71a58f1489136fbb19c9137/BUILD.gn

```
# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
config("jsoncpp_config") {
  include_dirs = [
    "overrides/include",
    "source/include",
  ]
}
source_set("jsoncpp") {
  sources = [
    "overrides/include/json/value.h",
    "overrides/src/lib_json/json_reader.cpp",
    "overrides/src/lib_json/json_value.cpp",
    "source/include/json/assertions.h",
    "source/include/json/autolink.h",
    "source/include/json/config.h",
    "source/include/json/features.h",
    "source/include/json/forwards.h",
    "source/include/json/json.h",
    "source/include/json/reader.h",
    "source/include/json/writer.h",
    "source/src/lib_json/json_batchallocator.h",
    "source/src/lib_json/json_tool.h",
    "source/src/lib_json/json_writer.cpp",
  ]
  public_configs = [ ":jsoncpp_config" ]
  defines = [ "JSON_USE_EXCEPTION=0" ]
  include_dirs = [ "source/src/lib_json" ]
}
```


```
optional("fontmgr_ohos") {
    enabled = skia_enable_fontmgr_ohos
    public = [
      "src/ports/skia_ohos/FontConfig_ohos.h",
      "src/ports/skia_ohos/FontInfo_ohos.h",
      "src/ports/skia_ohos/SkFontMgr_ohos.h",
      "src/ports/skia_ohos/SkFontStyleSet_ohos.h",
      "src/ports/skia_ohos/SkTypeface_ohos.h",
    ]
    sources = [
      "src/ports/skia_ohos/FontConfig_ohos.cpp",
      "src/ports/skia_ohos/SkFontMgr_ohos.cpp",
      "src/ports/skia_ohos/SkFontMgr_ohos_factory.cpp",
      "src/ports/skia_ohos/SkFontStyleSet_ohos.cpp",
      "src/ports/skia_ohos/SkTypeface_ohos.cpp",
    ]

    include_dirs = [
      ".",
      "include/private",
      "include/core",
      "src/core",
      "ports",
      "ports/skia_ohos",
    ]

    deps = [
      ":fontmgr_symbol_load",
      ":typeface_freetype",
      "//third_party/expat",
      "//third_party/jsoncpp",
    ]
    # deps += [ ":ohos_fontconfig.json" ]
}

optional("fontmgr_symbol_load") {
  enabled = skia_enable_fontmgr_ohos || skia_enable_fontmgr_win ||
            skia_use_fonthost_mac
  include_dirs = [
      ".",
      "include/private",
      "include/core",
      "src/core",
      "ports",
      "ports/skia_ohos",
    ]
  deps = [
    ":typeface_freetype",
    "//third_party/expat",
    "//third_party/jsoncpp",
  ]
  # deps += [ ":ohos_fontconfig.json" ]
  public = [ "src/ports/skia_ohos/HmSymbolConfig_ohos.h" ]
  sources = [ "src/ports/skia_ohos/HmSymbolConfig_ohos.cpp" ]
}
```
![image](https://github.com/forevermgg/ohos_skia/assets/93423027/071d0c0f-dadf-41f7-a67d-b4cada0a7bb9)
![image](https://github.com/forevermgg/ohos_skia/assets/93423027/649b9af9-1809-494c-aaaf-4029992fb734)
