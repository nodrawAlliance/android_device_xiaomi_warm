# config.mk
#
# Product-specific compile-time definitions.
#
# TODO(b/124534788): Temporarily allow eng and debug LOCAL_MODULE_TAGS

BOARD_SYSTEMSDK_VERSIONS := 34
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
ALLOW_MISSING_DEPENDENCIES := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

BOARD_RAMDISK_USE_LZ4 := true

# TODO: Enable it back when we have a path forward
# Disable generation of dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := false

### Dynamic partition Handling
# Define the Dynamic Partition sizes and groups.
BOARD_SUPER_PARTITION_SIZE := 6442450944
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := vendor vendor_dlkm system_dlkm odm
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x06400000

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
AB_OTA_PARTITIONS ?= boot init_boot dtbo odm product system system_dlkm system_ext recovery vbmeta vbmeta_system vendor vendor_boot vendor_dlkm
BOARD_EXT4_SHARE_DUP_BLOCKS := true

TARGET_NO_RECOVERY := true
# Defines for enabling A/B builds
AB_OTA_UPDATER := true
TARGET_RECOVERY_FSTAB := device/xiaomi/warm/init/fstab_AB_dynamic_partition.qti

# AVB
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_USES_METADATA_PARTITION := true
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Enable compilation of system_dlkm image
BOARD_USES_SYSTEM_DLKMIMAGE := true
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

#Enable Metadata compilation and adding metadata related attributes
BOARD_USES_METADATA_PARTITION := true
BOARD_METADATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_METADATAIMAGE_PARTITION_SIZE := 67108864

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 0x00800000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_DTBOIMG_PARTITION_SIZE := 0x0800000
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Use sha256 hash algorithm for system_dlkm partition
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# Enable chained vbmeta for boot images
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3

TARGET_USES_NEW_ION_API := true
TARGET_USES_SMMU_PROXY := true

BOARD_KERNEL_CMDLINE := video=vfb:640x400,bpp=32,memsize=3072000
BOARD_BOOTCONFIG := androidboot.hardware=qcom androidboot.memcg=1 androidboot.usbcontroller=4e00000.dwc3 androidboot.usb.dwc3_msm=4e00000.ssusb  androidboot.load_modules_parallel=true

# TARGET_CONSOLE_ENABLED allows to override the default kernel configuration
# true  -- override kernel configuration to enable console
# false -- override kernel configuration to disable console
# <blank> (default) -- use kernel default configuration
ifeq ($(TARGET_CONSOLE_ENABLED),true)
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 earlycon qcom_geni_serial.con_enabled=1
BOARD_BOOTCONFIG += androidboot.console=ttyMSM0
else
ifeq ($(TARGET_CONSOLE_ENABLED),false)
BOARD_KERNEL_CMDLINE += qcom_geni_serial.con_enabled=0
endif
endif

BOARD_KERNEL_CMDLINE += $(file < device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/extra_cmdline)
BOARD_BOOTCONFIG += $(file < device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/extra_bootconfig)

BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/

#Enable dtb in boot image and boot image header version 3 support.
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

# Specify init boot header version
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

#Add non-hlos files to ota packages
ADD_RADIO_FILES := false

#flag for qspm compilation
TARGET_USES_QSPM := true

#namespace definition for librecovery_updater
#differentiate legacy 'sg' or 'bsg' framework
SOONG_CONFIG_NAMESPACES += ufsbsg

SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# Include the proprietary files BoardConfig.
include vendor/xiaomi/warm/BoardConfigVendor.mk
