#!/bin/bash

clone_path="$1"

if [ -z "$clone_path" ]; then
  echo "Usage: $0 <clone_path>"
  exit 1
fi

remote="https://github.com"
user="kzubec"
user1="LineageOS"
audio_path="${clone_path}/hardware/qcom-caf/sm6225/audio"
caf_path="${clone_path}/hardware/qcom-caf/sm6225"

repo1="${remote}/${user}/android_vendor_qcom_opensource_agm.git"
path1="hardware/qcom-caf/sm6225/audio/agm"
branch1="lineage-21.0-caf-sm6225"

repo2="${remote}/${user}/android_vendor_qcom_opensource_arpal-lx.git"
path2="hardware/qcom-caf/sm6225/audio/pal"
branch2="lineage-21.0-caf-sm6225"

repo3="${remote}/${user}/android_hardware_qcom_audio.git"
path3="hardware/qcom-caf/sm6225/audio/primary-hal"
branch3="lineage-21.0-caf-sm6225"

repo4="${remote}/${user}/android_vendor_qcom_opensource_data-ipa-cfg-mgr.git"
path4="hardware/qcom-caf/sm6225/data-ipa-cfg-mgr"
branch4="lineage-21.0-caf-sm6225"

repo5="${remote}/${user}/android_vendor_qcom_opensource_dataipa.git"
path5="hardware/qcom-caf/sm6225/dataipa"
branch5="lineage-21.0-caf-sm6225"

repo6="${remote}/${user}/android_hardware_qcom_display.git"
path6="hardware/qcom-caf/sm6225/display"
branch6="lineage-21.0-caf-sm6225"

repo7="${remote}/${user}/android_hardware_qcom_media.git"
path7="hardware/qcom-caf/sm6225/media"
branch7="lineage-21.0-caf-sm6225"

repo8="${remote}/${user}/android_device_qcom_sepolicy_vndr.git"
path8="device/qcom/sepolicy_vndr/sm6225"
branch8="lineage-21.0-caf-sm6225"

repo9="${remote}/${user}/android_hardware_qcom-caf_common.git"
path9="hardware/qcom-caf/common"
branch9="lineage-21"

repo10="${remote}/${user}/android_device_xiaomi_tapas"
path10="device/xiaomi/tapas"
branch10="lineage-21"

repo11="${remote}/${user}/android_kernel_xiaomi_tapas"
path11="device/xiaomi/tapas/prebuilts"
branch11="lineage-21"

repo12="${remote}/${user}/android_vendor_xiaomi_tapas"
path12="vendor/xiaomi/tapas"
branch12="lineage-21"

repo13="${remote}/${user1}/android_hardware_xiaomi"
path13="hardware/xiaomi"
branch13="lineage-21"

for i in {1..13}; do
  repo_var="repo$i"
  branch_var="branch$i"
  path_var="path$i"
  full_path="$clone_path/${!path_var}"
  if [ -d "$full_path" ]; then
    rm -rf "$full_path"
  fi
  git clone "${!repo_var}" -b "${!branch_var}" "$full_path" || { echo "Error: Git clone failed for repository ${!repo_var}"; exit 1; }
done
  ln -s "${clone_path}/${path9}/os_pickup_audio-ar.mk" "${audio_path}/Android.mk"
  ln -s "${clone_path}/${path9}/os_pickup_qssi.bp" "${caf_path}/Android.bp"
  ln -s "${clone_path}/${path9}/os_pickup.mk" "${caf_path}/Android.mk"
