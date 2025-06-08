load(['Mu_R1.mat'])
%mu_nocsf(isnan(mu_nocsf))=0;
%mu_nocsf = permute(flip(flip(mu_nocsf, 1), 2), [2 1 3]);
tmp =load_untouch_nii('Mu_R1');
tmp.img = mu_nocsf;
save_untouch_nii(tmp,'tmp.nii')