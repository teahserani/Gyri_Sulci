#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <subject_name>"
    exit 1
fi

BASE_PATH="/Volumes/Teah2/Gyri_sulci/"
OUTPUT_DIR="${BASE_PATH}SG_Outputs/${1}_gy-sulc_Output/Ctx_Inner_Outer"
mkdir $OUTPUT_DIR

# Set SUBJECTS_DIR for FreeSurfer to find the subject folder
export SUBJECTS_DIR="${BASE_PATH}FreesurferOutputs"

mri_surf2vol --hemi lh --surf white --fill-projfrac 0 .25 0.05 \
--o "$OUTPUT_DIR/ctx-lh-inner.mgz" --identity "$1" \
--template "$SUBJECTS_DIR/$1/mri/nu.mgz" \
--mkmask --mask-to-cortex

mri_convert "$OUTPUT_DIR/ctx-lh-inner.mgz" "$OUTPUT_DIR/ctx-lh-inner.nii"

mri_surf2vol --hemi lh --surf white --fill-projfrac .75 1 0.05 \
--o "$OUTPUT_DIR/ctx-lh-outer.mgz" --identity "$1" \
--template "$SUBJECTS_DIR/$1/mri/nu.mgz" \
--mkmask --mask-to-cortex

mri_convert "$OUTPUT_DIR/ctx-lh-outer.mgz" "$OUTPUT_DIR/ctx-lh-outer.nii"

mri_surf2vol --hemi rh --surf white --fill-projfrac 0 .25 0.05 \
--o "$OUTPUT_DIR/ctx-rh-inner.mgz" --identity "$1" \
--template "$SUBJECTS_DIR/$1/mri/nu.mgz" \
--mkmask --mask-to-cortex

mri_convert "$OUTPUT_DIR/ctx-rh-inner.mgz" "$OUTPUT_DIR/ctx-rh-inner.nii"

mri_surf2vol --hemi rh --surf white --fill-projfrac .75 1 0.05 \
--o "$OUTPUT_DIR/ctx-rh-outer.mgz" --identity "$1" \
--template "$SUBJECTS_DIR/$1/mri/nu.mgz" \
--mkmask --mask-to-cortex

mri_convert "$OUTPUT_DIR/ctx-rh-outer.mgz" "$OUTPUT_DIR/ctx-rh-outer.nii"

