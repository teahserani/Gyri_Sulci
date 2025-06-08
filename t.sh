subjects=(
EA1046
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
sllip_030
)

BASE_PATH="/Volumes/Teah2/Gyri_sulci"
export SUBJECTS_DIR="${BASE_PATH}/FreesurferOutputs"



for subject in "${subjects[@]}"; do
    insomnia_path="/insomnia001/depts/mcilvain/users/teah/Gyri_sulci_subjects/$subject"

    local_path="${BASE_PATH}/SG_Outputs/${subject}_gy-sulc_Output"
    #sh crown_fund.sh "$subject"

    #ssh ts3641@insomnia.rcs.columbia.edu "mkdir -p '$insomnia_path'"

    rsync -avz --progress \
   "$local_path"/{nu.nii,lh_sulci.nii,rh_sulci.nii,lh_gyri.nii,rh_gyri.nii,Ctx_Inner_Outer/*.nii,frontalROI/*.nii,CrownFund/*.nii} \
   "${BASE_PATH}/Subjects/${subject}/t2stack.nii" \
   ts3641@insomnia.rcs.columbia.edu:"$insomnia_path"

done