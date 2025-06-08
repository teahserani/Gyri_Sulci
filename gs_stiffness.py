import numpy as np
import scipy as sp 
from scipy import stats
import matplotlib.pyplot as plt
import nibabel as nib
from scipy.ndimage import affine_transform
import surfa as sf
import matplotlib.colors as mcolors
import seaborn as sns


path='/Users/teahserani/Desktop/Gyri_sulci/SG_Outputs/388_21yrOld_edited_gy-sulc_Output/' #Fix this line 


lh_gyri_volume=nib.load(f'{path}lh_gyri-reg-nearest.nii')
lh_gyri=lh_gyri_volume.get_fdata()
lh_sulci_volume=nib.load(f'{path}lh_sulci-reg-nearest.nii')
lh_sulci=lh_sulci_volume.get_fdata()


mu_volume=nib.load(f'{path}Mu.nii')
mu_with_csf=mu_volume.get_fdata()


csf_volume=nib.load(f'{path}register_nu_csf.nii')
csf=csf_volume.get_fdata()
csf_mask=(csf < .5).astype(int)
nu_volume=nib.load(f'{path}register_nu.nii')
t1=nu_volume.get_fdata()


mu = mu_with_csf*csf_mask


mu_lh_gyri = mu*lh_gyri
mu_lh_sulci = mu*lh_sulci


plt.figure(figsize=(8, 8))

mu_lh_gyri_flat = mu_lh_gyri.flatten()
mu_lh_gyri_flat[mu_lh_gyri_flat == 0] = np.nan

mu_lh_sulci_flat = mu_lh_sulci.flatten()
mu_lh_sulci_flat[mu_lh_sulci_flat == 0] = np.nan
sns.boxplot(data=[mu_lh_gyri_flat/1000, mu_lh_sulci_flat/1000], palette='Accent')
plt.xticks([0, 1], ['Gyri', 'Sulci'])
plt.ylabel('Stiffness (kPa)')

plt.title('Left Hemsphere Gyri and Sulci Stiffness')
plt.ylabel('Stiffness (kPa)')
plt.show()


plt.figure(figsize=(10, 6))

plt.hist(mu_lh_gyri_flat/ 1000, bins=1000, alpha=0.5, label='Gyri', color='Green')
plt.hist(mu_lh_sulci_flat/ 1000, bins=1000, alpha=0.5, label='Sulci', color='Purple')

plt.legend(loc='best')
plt.xlabel('Stiffness (kPa)')
plt.ylabel('Frequency')
plt.title('Distribution of Gyri vs Sulci Stiffness')

plt.show()


mean_gyri = np.nanmean(mu_lh_gyri_flat)
print(f'gyri:{mean_gyri}')

mean_sulci = np.nanmean(mu_lh_sulci_flat)
print(f'sulci:{mean_sulci}')

percent_diff = (abs(mean_gyri - mean_sulci) / ((mean_gyri + mean_sulci) / 2)) * 100
print(f'percent difference: {percent_diff}')

