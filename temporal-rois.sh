#!/bin/bash

BASE_PATH="/Volumes/Teah2/Gyri_sulci/"
OUTPUT_DIR="${BASE_PATH}SG_Outputs/${1}_gy-sulc_Output"

mkdir $OUTPUT_DIR/frontalROI

MRI_DIR="${BASE_PATH}FreesurferOutputs/${1}/mri"

mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-middletemporal.nii --match 2015
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-inferiortemporal.nii  --match 2009
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-superiortemporal.nii  --match 2030
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-fusiform.nii  --match 2007
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-entorhinal.nii --match 2006
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-temporalpole.nii  --match 2033
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-rh-parahippocampal.nii  --match 2016 



mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-middletemporal.nii --match 1015
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-inferiortemporal.nii  --match 1009
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-superiortemporal.nii  --match 1030
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-fusiform.nii  --match 1007
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-entorhinal.nii --match 1006
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-temporalpole.nii  --match 1033
mri_binarize --i $MRI_DIR/aparc+aseg.mgz --o $OUTPUT_DIR/temporalROI/ctx-lh-parahippocampal.nii  --match 1016 
