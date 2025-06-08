#!/bin/bash

subject_id=${1}

local_path="/Volumes/Teah2/Gyri_sulci/SG_Outputs/${subject_id}_gy-sulc_Output/CrownFund"
export SUBJECTS_DIR=/Volumes/Teah2/Gyri_sulci/FreeSurferOutputs


mri_surf2vol --o $local_path/rh_sulc_fund.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/rh.pial ${local_path}/rh_sulc_fund.curv 
mri_surf2vol --o $local_path/lh_sulc_fund.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/lh.pial ${local_path}/lh_sulc_fund.curv  
mri_surf2vol --o $local_path/lh_gyri_crown.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/lh.pial ${local_path}/lh_gyri_crown.curv 
mri_surf2vol --o $local_path/rh_gyri_crown.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/rh.pial ${local_path}/rh_gyri_crown.curv

mri_convert "$local_path/rh_sulc_fund.mgz" "$local_path/rh_sulc_fund.nii"
mri_convert "$local_path/lh_sulc_fund.mgz" "$local_path/lh_sulc_fund.nii"
mri_convert "$local_path/lh_gyri_crown.mgz" "$local_path/lh_gyri_crown.nii"
mri_convert "$local_path/rh_gyri_crown.mgz" "$local_path/rh_gyri_crown.nii"