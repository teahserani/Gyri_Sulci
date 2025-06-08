#!/bin/bash

BASE_PATH="/Volumes/Teah2/Gyri_sulci/"

# Check for the -hd flag
while getopts "hd" opt; do
    case ${opt} in
        d)
            BASE_PATH="/Volumes/Teah1/"
    esac
done
shift $((OPTIND -1))

if [ -z "$1" ]; then
    echo "Usage: $0 <subject_name>"
    exit 1
fi

OUTPUT_DIR="${BASE_PATH}SG_Outputs/${1}_gy-sulc_Output"
mkdir -p "$OUTPUT_DIR"

date >> "$OUTPUT_DIR/log.txt"

cd "${BASE_PATH}FreesurferOutputs" 
pwd
export SUBJECTS_DIR=$(pwd)


echo "Using SUBJECTS_DIR: $SUBJECTS_DIR" >> "$OUTPUT_DIR/log.txt"

echo "-------------------------------------------convert mgz to nii----------------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_convert "$1/mri/nu.mgz" "$OUTPUT_DIR/nu.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "-----------------------------------starting mean curvature for left hemi-----------------------------------" >> "$OUTPUT_DIR/log.txt"
mris_curvature -w -a 10 "$1/surf/lh.pial" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "-----------------------------------starting mean curvature for right hemi----------------------------------" >> "$OUTPUT_DIR/log.txt"
mris_curvature -w -a 10 "$1/surf/rh.pial" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "-----------------------------------converting left hemi to volume---------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_surf2vol --o "$OUTPUT_DIR/lh_sulcgyr.mgz" \
              --subject "$1" \
              --so "$1/surf/lh.pial" "$1/surf/lh.pial.H" >> "$OUTPUT_DIR/log.txt"
mri_convert "$OUTPUT_DIR/lh_sulcgyr.mgz" "$OUTPUT_DIR/lh_sulcgyr.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "-----------------------------------converting right hemi to volume---------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_surf2vol --o "$OUTPUT_DIR/rh_sulcgyr.mgz" \
              --subject "$1" \
              --so "$1/surf/rh.pial" "$1/surf/rh.pial.H" >> "$OUTPUT_DIR/log.txt"
mri_convert "$OUTPUT_DIR/rh_sulcgyr.mgz" "$OUTPUT_DIR/rh_sulcgyr.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "----------------------------------------making left sulci mask----------------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_binarize --i "$OUTPUT_DIR/lh_sulcgyr.mgz" \
              --o "$OUTPUT_DIR/lh_sulci.mgz" \
              --binval 1 --binvalnot 0 --min 0.0001 >> "$OUTPUT_DIR/log.txt"
mri_convert "$OUTPUT_DIR/lh_sulci.mgz" "$OUTPUT_DIR/lh_sulci.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "----------------------------------------making right sulci mask----------------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_binarize --i "$OUTPUT_DIR/rh_sulcgyr.mgz" \
              --o "$OUTPUT_DIR/rh_sulci.mgz" \
              --binval 1 --binvalnot 0 --min 0.0001 >> "$OUTPUT_DIR/log.txt" 2>&1
mri_convert "$OUTPUT_DIR/rh_sulci.mgz" "$OUTPUT_DIR/rh_sulci.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "----------------------------------------making left gyri mask----------------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_binarize --i "$OUTPUT_DIR/lh_sulcgyr.mgz" \
              --o "$OUTPUT_DIR/lh_gyri.mgz" \
              --binval 1 --binvalnot 0 --max -0.0001 >> "$OUTPUT_DIR/log.txt" 2>&1
mri_convert "$OUTPUT_DIR/lh_gyri.mgz" "$OUTPUT_DIR/lh_gyri.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo "----------------------------------------making right gyri mask----------------------------------------------" >> "$OUTPUT_DIR/log.txt"
mri_binarize --i "$OUTPUT_DIR/rh_sulcgyr.mgz" \
              --o "$OUTPUT_DIR/rh_gyri.mgz" \
              --binval 1 --binvalnot 0 --max -0.0001 >> "$OUTPUT_DIR/log.txt" 2>&1
mri_convert "$OUTPUT_DIR/rh_gyri.mgz" "$OUTPUT_DIR/rh_gyri.nii" >> "$OUTPUT_DIR/log.txt" 2>&1

echo " sulci gyri masks done" >> "$OUTPUT_DIR/log.txt"