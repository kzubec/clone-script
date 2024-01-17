#!/bin/bash

clone_path="$1"

if [ -z "$clone_path" ]; then
  echo "Usage: $0 <clone_path>"
  exit 1
fi

github_remote="https://github.com"
github_user="kzubec"
lineage_user="LineageOS"

repositories=(
  "android_vendor_qcom_opensource_agm.git"
  "android_vendor_qcom_opensource_arpal-lx.git"
  "android_hardware_qcom_audio.git"
  "android_vendor_qcom_opensource_data-ipa-cfg-mgr.git"
  "android_vendor_qcom_opensource_dataipa.git"
  "android_hardware_qcom_display.git"
  "android_hardware_qcom_media.git"
  "android_device_qcom_sepolicy_vndr.git"
  "android_hardware_qcom-caf_common.git"
  "android_device_xiaomi_tapas.git"
  "android_kernel_xiaomi_tapas.git"
  "android_vendor_xiaomi_tapas.git"
  "android_hardware_xiaomi.git"
)

branchs=(
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21.0-caf-sm6225"
  "lineage-21"
  "lineage-21"
  "lineage-21"
  "lineage-21"
  "lineage-21"
)

paths=(
  "hardware/qcom-caf/sm6225/audio/agm"
  "hardware/qcom-caf/sm6225/audio/pal"
  "hardware/qcom-caf/sm6225/audio/primary-hal"
  "hardware/qcom-caf/sm6225/data-ipa-cfg-mgr"
  "hardware/qcom-caf/sm6225/dataipa"
  "hardware/qcom-caf/sm6225/display"
  "hardware/qcom-caf/sm6225/media"
  "device/qcom/sepolicy_vndr/sm6225"
  "hardware/qcom-caf/common"
  "device/xiaomi/tapas"
  "device/xiaomi/tapas/prebuilts"
  "vendor/xiaomi/tapas"
  "hardware/xiaomi"
)

platforms=(
  "msm8953"
  "msm8996"
  "msm8998"
  "sdm660"
  "sdm845"
  "sm6225"
  "sm8150"
  "sm8250"
  "sm8350"
  "sm8450"
  "sm8550"
)

for i in "${!repositories[@]}"; do
  paths_path="${clone_path}/${paths[i]}"
  
  if [ -d "$paths_path" ]; then
    rm -rf "$paths_path"
  fi

  if [ "${repositories[i]}" == "android_hardware_xiaomi.git" ]; then
    git clone "${github_remote}/${lineage_user}/${repositories[i]}" -b "${branchs[i]}" "${paths_path}" || { echo "Error: Git clone failed for repository ${repositories[i]}"; exit 1; }
  else
    git clone "${github_remote}/${github_user}/${repositories[i]}" -b "${branchs[i]}" "${paths_path}" || { echo "Error: Git clone failed for repository ${repositories[i]}"; exit 1; }
  fi
done

  for platform in "${platforms[@]}"; do
    platform_path="${clone_path}/hardware/qcom-caf/${platform}"
    audio_path="${platform_path}/audio"
    common_path="${clone_path}/hardware/qcom-caf/common"
    ln -s "${common_path}/os_pickup_audio-ar.mk" "${audio_path}/Android.mk"
    ln -s "${common_path}/os_pickup_qssi.bp" "${platform_path}/Android.bp"
    ln -s "${common_path}/os_pickup.mk" "${platform_path}/Android.mk"
done

