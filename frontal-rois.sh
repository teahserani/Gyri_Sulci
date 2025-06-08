#!/bin/bash

BASE_PATH="/Volumes/Teah2/Gyri_sulci/"
OUTPUT_DIR="${BASE_PATH}SG_Outputs/${1}_gy-sulc_Output"

mkdir $OUTPUT_DIR/frontalROI

MRI_DIR="${BASE_PATH}FreesurferOutputs/${1}/mri"

mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-superiorfrontal.nii --match 2028
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-rostralmiddlefrontal.nii  --match 2027
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-caudalmiddlefrontal.nii  --match 2003
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-parsopercularis.nii  --match 2018
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-parsorbitalis.nii --match 2019 
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-parstriangularis.nii  --match 2020
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-lateralorbitofrontal.nii  --match 2012
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-frontalpole.nii  --match 2032
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-precentral.nii  --match 2024
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-rh-paracentral.nii  --match 2017


mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-superiorfrontal.nii --match 1028
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-rostralmiddlefrontal.nii  --match 1027
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-caudalmiddlefrontal.nii  --match 1003
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-parsopercularis.nii  --match 1018
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-parsorbitalis.nii --match 1019 
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-parstriangularis.nii  --match 1020
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-lateralorbitofrontal.nii  --match 1012
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-frontalpole.nii  --match 1032
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-precentral.nii  --match 1024
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/frontalROI/ctx-lh-paracentral.nii  --match 1017

