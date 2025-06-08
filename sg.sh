subjects=(
366_53yrOld_edited
388_21yrOld_edited
401_5yrOld_edited
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
)

BASE_PATH="/Volumes/Teah2/Gyri_sulci"
export SUBJECTS_DIR="${BASE_PATH}FreesurferOutputs"



for subject in "${subjects[@]}"; do
    insomnia_path="/insomnia001/depts/mcilvain/users/teah/Gyri_sulci_subjects/$subject"

    local_path="${BASE_PATH}/SG_Outputs/${subject}_gy-sulc_Output"
    mkdir $local_path
    echo "$subject"
    mkdir ${local_path}/FinalOutputs

    #####python3 final_outputs.py $subject
    sh gyri-sulc-mask.sh "$subject"
    python3 mat2nii.py "$subject"
    sh inner_outer_vox.sh "$subject"
    sh frontal-rois.sh "$subject"

    mkdir ${local_path}/CrownFund
    mkdir ${local_path}/FinalOutputs
    python3 crown_fundus_curv.py "$subject"
    sh crown_fund.sh "$subject"

    ssh ts3641@insomnia.rcs.columbia.edu "mkdir -p '$insomnia_path'"
    rsync -avz --progress \
    "$local_path"/{nu.nii,lh_sulci.nii,rh_sulci.nii,lh_gyri.nii,rh_gyri.nii,Ctx_Inner_Outer/*.nii,frontalROI/*.nii,CrownFund/*.nii} \
    "${BASE_PATH}/Subjects/${subject}/t2stack.nii" \
    ts3641@insomnia.rcs.columbia.edu:"$insomnia_path"

done