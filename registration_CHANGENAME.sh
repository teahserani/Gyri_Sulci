
#registeration
mri_synthmorph register -m affine -t aff.lta -o nu_reg.nii nu.nii t2stack.nii
mri_synthmorph apply aff.lta -m nearest lh_gyri.nii lh_gyri-reg-nearest.nii
mri_synthmorph apply aff.lta -m nearest rh_gyri.nii rh_gyri-reg-nearest.nii

mri_synthmorph apply aff.lta -m nearest lh_sulci.nii lh_sulci-reg-nearest.nii
mri_synthmorph apply aff.lta -m nearest rh_sulci.nii rh_sulci-reg-nearest.nii


mri_synthmorph apply aff.lta -m nearest \
ctx-lh-caudalmiddlefrontal.nii ctx-lh-caudalmiddlefrontal-reg-nearest.nii \
ctx-lh-frontalpole.nii ctx-lh-frontalpole-reg-nearest.nii \
ctx-lh-lateralorbitofrontal.nii ctx-lh-lateralorbitofrontal-reg-nearest.nii \
ctx-lh-paracentral.nii ctx-lh-paracentral-reg-nearest.nii \
ctx-lh-parsopercularis.nii ctx-lh-parsopercularis-reg-nearest.nii \
ctx-lh-parsorbitalis.nii ctx-lh-parsorbitalis-reg-nearest.nii \
ctx-lh-parstriangularis.nii ctx-lh-parstriangularis-reg-nearest.nii \
ctx-lh-precentral.nii ctx-lh-precentral-reg-nearest.nii \
ctx-lh-rostralmiddlefrontal.nii ctx-lh-rostralmiddlefrontal-reg-nearest.nii \
ctx-lh-superiorfrontal.nii ctx-lh-superiorfrontal-reg-nearest.nii 

mri_synthmorph apply aff.lta -m nearest \
ctx-rh-caudalmiddlefrontal.nii ctx-rh-caudalmiddlefrontal-reg-nearest.nii \
ctx-rh-frontalpole.nii ctx-rh-frontalpole-reg-nearest.nii \
ctx-rh-lateralorbitofrontal.nii ctx-rh-lateralorbitofrontal-reg-nearest.nii \
ctx-rh-paracentral.nii ctx-rh-paracentral-reg-nearest.nii \
ctx-rh-parsopercularis.nii ctx-rh-parsopercularis-reg-nearest.nii \
ctx-rh-parsorbitalis.nii ctx-rh-parsorbitalis-reg-nearest.nii \
ctx-rh-parstriangularis.nii ctx-rh-parstriangularis-reg-nearest.nii \
ctx-rh-precentral.nii ctx-rh-precentral-reg-nearest.nii \
ctx-rh-rostralmiddlefrontal.nii ctx-rh-rostralmiddlefrontal-reg-nearest.nii \
ctx-rh-superiorfrontal.nii ctx-rh-superiorfrontal-reg-nearest.nii
