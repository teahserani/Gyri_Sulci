#!/bin/bash

subjects=(
  366_53yrOld_edited
388_21yrOld_edited
401_5yrOld_edited
EA1046
EA1048A
EA1049A
EA1050A
EA1050B
EA1051A
EA1052A
EA1055A
EA1056A
EA1057A
EA1058A
EA1062A
EA1063A
EA1064A
EA1065A
EA1069A
EA1070A
EA1072A
EA1073A
EA1073B
EA1074A
EA1076A
EA1078B
EA1079A
MIMS_HC_036
MIMS_HC_037
MIMS_HC_038
MIMS_HC_039
MIMS_HC_040
MIMS_HC_043
MIMS_HC_045
MIMS_HC_047
MIMS_HC_049
MIMS_HC_050
MIMS_HC_051
MIMS_HC_052
MIMS_HC_053
MIMS_HC_056
MIMS_HC_057
MIMS_HC_059
MIMS_HC_060
MIMS_HC_061
MIMS_HC_062
MIMS_HC_064
MIMS_HC_065
MIMS_HC_066
EA1046
EA1048A
EA1049A
EA1050A
EA1050B
EA1051A
EA1052A
EA1055A
EA1056A
EA1057A
EA1058A
EA1062A
EA1063A
EA1064A
EA1065A
EA1069A
EA1070A
EA1072A
EA1073A
EA1073B
EA1074A
EA1076A
EA1078B
EA1079A
STE_001
STE_002
STE_003
STE_004
STE_005
STE_006
STE_007
STE_008
STE_009
STE_010
STE_011
STE_016
STE_017
STE_018
U01_001
U01_002
U01_003
U01_004
U01_005
U01_006
U01_D2002
blast_c_269
sllip_001
sllip_002
sllip_007
sllip_008
sllip_010
sllip_013
sllip_014
sllip_016
sllip_017
sllip_018
sllip_023
sllip_025
sllip_026
sllip_027
sllip_029
sllip_030
 )

frontal=(
  "ctx-lh-caudalmiddlefrontal-reg-nearest.nii" "ctx-lh-frontalpole-reg-nearest.nii" "ctx-lh-lateralorbitofrontal-reg-nearest.nii"
  "ctx-lh-paracentral-reg-nearest.nii" "ctx-lh-parsopercularis-reg-nearest.nii" "ctx-lh-parsorbitalis-reg-nearest.nii"
  "ctx-lh-parstriangularis-reg-nearest.nii" "ctx-lh-precentral-reg-nearest.nii" "ctx-lh-rostralmiddlefrontal-reg-nearest.nii"
  "ctx-lh-superiorfrontal-reg-nearest.nii" "ctx-rh-caudalmiddlefrontal-reg-nearest.nii" "ctx-rh-frontalpole-reg-nearest.nii"
  "ctx-rh-lateralorbitofrontal-reg-nearest.nii" "ctx-rh-paracentral-reg-nearest.nii" "ctx-rh-parsopercularis-reg-nearest.nii"
  "ctx-rh-parsorbitalis-reg-nearest.nii" "ctx-rh-parstriangularis-reg-nearest.nii" "ctx-rh-precentral-reg-nearest.nii"
  "ctx-rh-rostralmiddlefrontal-reg-nearest.nii" "ctx-rh-superiorfrontal-reg-nearest.nii"
)

inner_outer=(
  "ctx-lh-inner-reg-nearest.nii" "ctx-lh-outer-reg-nearest.nii"
  "ctx-rh-inner-reg-nearest.nii" "ctx-rh-outer-reg-nearest.nii"
)

sulci_gyri=(
  "lh_sulci-reg-nearest.nii" "rh_sulci-reg-nearest.nii"
  "lh_gyri-reg-nearest.nii" "rh_gyri-reg-nearest.nii" "nu_reg.nii"
)

crown_fund=(
  "lh_gyri_crown-reg-nearest.nii"
  "lh_sulc_fund-reg-nearest.nii"
  "rh_gyri_crown-reg-nearest.nii"
  "rh_sulc_fund-reg-nearest.nii"
)
BASE_PATH="/Volumes/Teah2/Gyri_sulci"

for subject in "${subjects[@]}"; do
  echo "Processing $subject"

  insomnia_path="/insomnia001/depts/mcilvain/users/teah/Gyri_sulci_subjects/$subject"
  local_path="${BASE_PATH}/SG_Outputs/${subject}_gy-sulc_Output"
  temp_path="${local_path}/tmp_download"

  python3 mat2nii.py "$subject"

  mkdir -p "$temp_path" "$local_path/frontalROI" "$local_path/Ctx_Inner_Outer"

  #scp -r "ts3641@insomnia.rcs.columbia.edu:$insomnia_path/*reg*" "$temp_path/"

  rsync -avz --progress --include="*reg*" --exclude="*" \
  ts3641@insomnia.rcs.columbia.edu:"$insomnia_path/" "$temp_path/"


  for roi in "${frontal[@]}"; do
    mv "$temp_path/$roi" "$local_path/frontalROI/" 2>/dev/null
  done

  for roi in "${inner_outer[@]}"; do
    mv "$temp_path/$roi" "$local_path/Ctx_Inner_Outer/" 2>/dev/null
  done

  for roi in "${sulci_gyri[@]}"; do
    mv "$temp_path/$roi" "$local_path/" 2>/dev/null
  done

  for roi in "${crown_fund[@]}"; do
    mv "$temp_path/$roi" "$local_path/CrownFund/" 2>/dev/null
  done

  mv "$temp_path/nu_reg.nii" "$local_path/" 2>/dev/null
  rm -rf "$temp_path"

  #sh csf-mask.sh "$subject"

  #mkdir ${local_path}/FinalOutputs
  #python3 final_outputs.py $subject
  python3 crown_fund_final_outputs.py $subject

done
