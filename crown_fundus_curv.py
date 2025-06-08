import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt
import surfa as sf 
from nibabel.freesurfer.io import write_morph_data
import trimesh
from sklearn.preprocessing import MinMaxScaler
import nibabel.freesurfer.io as fsio
import seaborn as sns
import pandas as pd
import sys
import os

if len(sys.argv) < 2:
    print("Error: Subject ID not provided.")
    sys.exit(1)

subject_id = sys.argv[1]

FreeSurferOutput='/Volumes/Teah2/Gyri_sulci/FreeSurferOutputs'

lh_pial_file = f'{FreeSurferOutput}/{subject_id}/surf/lh.pial'
lh_white_file = f'{FreeSurferOutput}/{subject_id}/surf/lh.white'
lh_curv_file = f'{FreeSurferOutput}/{subject_id}/surf/lh.curv'

rh_pial_file = f'{FreeSurferOutput}/{subject_id}/surf/rh.pial'
rh_white_file = f'{FreeSurferOutput}/{subject_id}/surf/rh.white'
rh_curv_file = f'{FreeSurferOutput}/{subject_id}/surf/rh.curv'


lh_pial_mesh = sf.load_mesh(lh_pial_file)
lh_white_mesh = sf.load_mesh(lh_white_file)
lh_curv_mesh = sf.load_overlay(lh_curv_file)
lh_curv = lh_curv_mesh.data

rh_pial_mesh = sf.load_mesh(rh_pial_file)
rh_white_mesh = sf.load_mesh(rh_white_file)
rh_curv_mesh = sf.load_overlay(rh_curv_file)
rh_curv = rh_curv_mesh.data

curv_all = np.concatenate([lh_curv, rh_curv])

rh_negative_curv = rh_curv[rh_curv < 0]
rh_bottom_threshold = np.percentile(rh_negative_curv, 60)

rh_positive_curv = rh_curv[rh_curv > 0]
rh_top_threshold = np.percentile(rh_positive_curv, 70)

rh_gyri_crown = (rh_curv <= rh_bottom_threshold).astype(np.float32)
rh_sulc_fund = (rh_curv >= rh_top_threshold).astype(np.float32)

lh_negative_curv = lh_curv[lh_curv < 0]
lh_bottom_threshold = np.percentile(lh_negative_curv, 60)

lh_positive_curv = lh_curv[lh_curv > 0]
lh_top_threshold = np.percentile(lh_positive_curv, 70)

lh_gyri_crown = (lh_curv <= lh_bottom_threshold).astype(np.float32)
lh_sulc_fund = (lh_curv >= lh_top_threshold).astype(np.float32)


fsio.write_morph_data(f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/CrownFund/rh_gyri_crown.curv', rh_gyri_crown)
fsio.write_morph_data(f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/CrownFund/rh_sulc_fund.curv', rh_sulc_fund)
fsio.write_morph_data(f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/CrownFund/lh_gyri_crown.curv', lh_gyri_crown)
fsio.write_morph_data(f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/CrownFund/lh_sulc_fund.curv', lh_sulc_fund)

df = pd.DataFrame({
    'Curvature': curv_all,
})
plt.figure(figsize=(10, 5))

sns.histplot(df['Curvature'], kde=False, bins=2000, color='steelblue',edgecolor='white')
plt.xlim(-2,2)
plt.xlabel("Mean Curvature (mm$^{-1}$)")
plt.title('Mean Curvature Distribution')
image_path = f'/Volumes/Teah2/Gyri_sulci/SG_Outputs/{subject_id}_gy-sulc_Output/FinalOutputs/MeanCurvature.png'
plt.savefig(image_path, dpi=300, bbox_inches='tight')