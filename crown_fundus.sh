#!/bin/bash

if len(sys.argv) < 2:
    print("Error: Subject ID not provided.")
    sys.exit(1)

subject_id = sys.argv[1]

local_path="/Volumes/Teah2/Gyri_sulci/${subject_id}_gy-sulc_Output/CrownFund"
export SUBJECTS_DIR=/Users/teahserani/Desktop/Gyri_sulci/FreeSurferOutputs


mri_surf2vol --o rh_sulc_fund.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/rh.pial ${local_path}/rh_sulc_fund.curv 
mri_surf2vol --o lh_sulc_fund.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/lh.pial ${local_path}/lh_sulc_fund.curv  
mri_surf2vol --o lh_gyri_crown.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/lh.pial ${local_path}/lh_gyri_crown.curv 
mri_surf2vol --o rh_gyri_crown.mgz --subject ${subject_id} --so $SUBJECTS_DIR/${subject_id}/surf/rh.pial ${local_path}/rh_gyri_crown.curv

mri_convert "$local_path/rh_sulc_fund.mgz" "$local_path/rh_sulc_fund.nii"
mri_convert "$local_path/lh_sulc_fund.mgz" "$local_path/lh_sulc_fund.nii"
mri_convert "$local_path/lh_gyri_crown.mgz" "$local_path/lh_gyri_crown.nii"
mri_convert "$local_path/rh_gyri_crown.mgz" "$local_path/rh_gyri_crown.nii"