#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <subject_name>"
    exit 1
fi
BASE_PATH="/Users/teahserani/Desktop/Gyri_sulci"
FS_SUB_PATH="$BASE_PATH/FreeSurferOutputs/"


while getopts "hd" opt; do
    case ${opt} in
        d)
            BASE_PATH="/Volumes/Teah1"
    esac
done
shift $((OPTIND -1))
OUTPUT_DIR="${BASE_PATH}/SG_Outputs/${1}_gy-sulc_Output"

date >> "$OUTPUT_DIR/reg_sg_log.txt"
#fslchfiletype NIFTI "$FS_SUB_PATH/$1/mri/orig/001.nii"
#fslchfiletype NIFTI "$OUTPUT_DIR/rh_sulcgyr.nii"
#fslchfiletype NIFTI "$OUTPUT_DIR/lh_sulcgyr.nii"

#-------------------------------------------registering brain.nii to t2stack.nii --------------------------------------------- >> "$OUTPUT_DIR/reg_sg_log.txt" 
#flirt -v -in "$OUTPUT_DIR/brain.nii" \
#      -ref "$BASE_PATH/stiffness_data/$1/t2bet.nii" \
#      -out "$OUTPUT_DIR/reg_brain.nii" \
#      -omat "$OUTPUT_DIR/reg_brain_matrix.mat" >> "$OUTPUT_DIR/reg_sg_log.txt" 2>&1


flirt -v -in "$FS_SUB_PATH/$1/mri/orig/001.nii" \
      -ref "$BASE_PATH/stiffness_data/$1/t2bet.nii" \
      -out "$OUTPUT_DIR/reg_001.nii" \
      -omat "$OUTPUT_DIR/reg_001_matrix.mat" -cost leastsq -dof 24 >> "$OUTPUT_DIR/reg_sg_log.txt" 2>&1 # -cost mutualinfo -dof 24

gunzip $OUTPUT_DIR/reg_001.nii.gz

#-------------------------------------------registering lh mask to t2stack.nii --------------------------------------------- >> "$OUTPUT_DIR/reg_sg_log.txt" 
flirt -v -in "$OUTPUT_DIR/lh_sulcgyr.nii" \
      -ref "$OUTPUT_DIR/reg_001.nii" \
      -out "$OUTPUT_DIR/reg_lh_sulcgyr.nii" \
      -applyxfm -init "$OUTPUT_DIR/reg_001_matrix.mat" -cost leastsq -dof 24  >> "$OUTPUT_DIR/reg_sg_log.txt" 2>&1
#-------------------------------------------registering rh mask to t2stack.nii --------------------------------------------- >> "$OUTPUT_DIR/reg_sg_log.txt" 
flirt -v -in "$OUTPUT_DIR/rh_sulcgyr.nii" \
      -ref "$OUTPUT_DIR/reg_001.nii" \
      -out "$OUTPUT_DIR/reg_rh_sulcgyr.nii" \
      -applyxfm -init "$OUTPUT_DIR/reg_001_matrix.mat" -cost leastsq -dof 24 >> "$OUTPUT_DIR/reg_sg_log.txt" #2>&1

gunzip $OUTPUT_DIR/reg_lh_sulgyr.nii.gz
gunzip $OUTPUT_DIR/reg_rh_sulgyr.nii.gz

echo " sulci gyri registration done"