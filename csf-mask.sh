#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <subject_name>"
    exit 1
fi

OUTPUT_DIR="/Volumes/Teah2/Gyri_sulci/SG_Outputs/${1}_gy-sulc_Output"

echo $OUTPUT_DIR


fast $OUTPUT_DIR/nu_reg.nii >> $OUTPUT_DIR/csf_log.txt 2>&1
gunzip $OUTPUT_DIR/nu_reg_pve_0.nii.gz
mv  $OUTPUT_DIR/nu_reg_pve_0.nii $OUTPUT_DIR/register_nu_csf.nii

mkdir $OUTPUT_DIR/fast
mv $OUTPUT_DIR/*nii.gz $OUTPUT_DIR/fast