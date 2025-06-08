import scipy.io
import nibabel as nib
import numpy as np
import sys

if len(sys.argv) < 2:
    print("Error: Subject ID not provided.")
    sys.exit(1)  # Exit if subject ID is not provided

# Get the subject ID from command-line arguments
subject_id = sys.argv[1]

mat_data = scipy.io.loadmat(f'/Volumes/Teah2/Gyri_sulci/Subjects/{subject_id}/Mu.mat') 
t2stack = nib.load(f'/Volumes/Teah2/Gyri_sulci/Subjects/{subject_id}/t2stack.nii')


image_data = mat_data['Mu']
image_data = np.flip(np.flip(np.transpose(image_data, (1, 0, 2)), axis=0), axis=1)
image_data[np.isnan(image_data)] = 0


#t1 = nib.load('/Users/teahserani/Desktop/Gyri_sulci/FreeSurferOutputs/366_53yrOld_edited/mri/brain.nii')

mu_nifti = nib.Nifti1Image(image_data, affine=t2stack.affine)
#mu_nifti = nib.Nifti1Image(image_data, affine=t1.affine)

for ext in t2stack.header.extensions:
    mu_nifti.header.extensions.append(ext)
    
# Save the image as a .nii file
nib.save(mu_nifti, f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/Mu.nii')