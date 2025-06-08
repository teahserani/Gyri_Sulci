#!/bin/bash

subjects=(EA1046
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
sllip_030)

for subject in "${subjects[@]}"; do
    echo "Processing $subject"

    sub_path="/insomnia001/depts/mcilvain/users/teah/Gyri_sulci_subjects/$subject"

    mri_synthmorph register -m affine -t "$sub_path/aff.lta" -o "$sub_path/nu_reg.nii" "$sub_path/nu.nii" "$sub_path/t2stack.nii"

    mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/lh_gyri.nii" "$sub_path/lh_gyri-reg-nearest.nii" -m nearest
    mri_synthmorph apply -t float32 "$sub_path/aff.lta"  "$sub_path/rh_gyri.nii" "$sub_path/rh_gyri-reg-nearest.nii" -m nearest

    mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/rh_sulci.nii" "$sub_path/rh_sulci-reg-nearest.nii" -m nearest
    mri_synthmorph apply -t float32 "$sub_path/aff.lta"  "$sub_path/lh_sulci.nii" "$sub_path/lh_sulci-reg-nearest.nii" -m nearest

    mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/ctx-lh-outer.mgz" "$sub_path/ctx-lh-outer-reg-nearest.nii" -m nearest
    mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/ctx-lh-inner.mgz" "$sub_path/ctx-lh-inner-reg-nearest.nii" -m nearest

    mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/ctx-rh-inner.mgz" "$sub_path/ctx-rh-inner-reg-nearest.nii" -m nearest
     mri_synthmorph apply -t float32 "$sub_path/aff.lta" "$sub_path/ctx-rh-outer.mgz" "$sub_path/ctx-rh-outer-reg-nearest.nii" -m nearest

    mri_synthmorph apply aff.lta -m nearest \
    ctx-lh-caudalmiddlefrontal.nii ctx-lh-caudalmiddlefrontal-reg-nearest.nii \
    ctx-lh-frontalpole.nii ctx-lh-frontalpole-reg-nearest.nii \
    ctx-lh-lateralorbitofrontal.nii ctx-lh-lateralorbitofrontal-reg-nearest.nii \
    ctx-lh-paracentral.nii ctx-lh-paracentral-reg-nearest.nii \
    ctx-lh-parsopercularis.nii ctx-lh-parsopercularis-reg-nearest.nii \
    ctx-lh-parsorbitalis.nii ctx-lh-parsorbitalis-reg-nearest.nii \
    ctx-lh-parstriangularis.nii ctx-lh-parstriangularis-reg-nearest.nii \
    ctx-lh-precentral.nii ctx-lh-precentral-reg-nearest.nii \
    ctx-lh-rostralmiddlefrontal.nii ctx-lh-rostralmiddlefrontal-reg-nearest.nii \
    ctx-lh-superiorfrontal.nii ctx-lh-superiorfrontal-reg-nearest.nii 

    mri_synthmorph apply aff.lta -m nearest \
    ctx-rh-caudalmiddlefrontal.nii ctx-rh-caudalmiddlefrontal-reg-nearest.nii \
    ctx-rh-frontalpole.nii ctx-rh-frontalpole-reg-nearest.nii \
    ctx-rh-lateralorbitofrontal.nii ctx-rh-lateralorbitofrontal-reg-nearest.nii \
    ctx-rh-paracentral.nii ctx-rh-paracentral-reg-nearest.nii \
    ctx-rh-parsopercularis.nii ctx-rh-parsopercularis-reg-nearest.nii \
    ctx-rh-parsorbitalis.nii ctx-rh-parsorbitalis-reg-nearest.nii \
    ctx-rh-parstriangularis.nii ctx-rh-parstriangularis-reg-nearest.nii \
    ctx-rh-precentral.nii ctx-rh-precentral-reg-nearest.nii \
    ctx-rh-rostralmiddlefrontal.nii ctx-rh-rostralmiddlefrontal-reg-nearest.nii \
    ctx-rh-superiorfrontal.nii ctx-rh-superiorfrontal-reg-nearest.nii


done

