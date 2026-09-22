#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    "hardware/xiaomi",
    "vendor/qcom/common/vendor/adreno/u",
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f"{lib}_{partition}" if partition == "vendor" else None


lib_fixups: lib_fixups_user_type = {**lib_fixups}

blob_fixups: blob_fixups_user_type = {
}  # fmt: skip

module = ExtractUtilsModule(
    "warm",
    "xiaomi",
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    add_firmware_proprietary_file=False,
)

if __name__ == "__main__":
    utils = ExtractUtils.device(module)
    utils.run()
