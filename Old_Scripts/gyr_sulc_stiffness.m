subject_name = '388_21yrOld';
figure_on = 0;

lh = load_nii(['/Users/teahserani/Desktop/Gyri_sulci/SG_Outputs/' subject_name '_gy-sulc_Output/registered_lh.nii']);
lh_flip = flip(flip(permute(lh.img,[2 1 3]),1),2);
lh_flip(lh_flip==0) = NaN;

lh_gry = lh_flip < 0; 
lh_sul = lh_flip > 0;

rh = load_nii(['/Users/teahserani/Desktop/Gyri_sulci/SG_Outputs/' subject_name '_gy-sulc_Output/registered_rh.nii']);
rh_flip = flip(flip(permute(rh.img,[2 1 3]),1),2);
rh_flip(rh_flip==0) = NaN;
rh_gry = rh_flip < 0; 
rh_sul = rh_flip > 0;

load(['/Users/teahserani/Desktop/Gyri_sulci/stiffness_data/' subject_name '/Mu.mat']);

csf = load_nii(['//Users/teahserani/Desktop/Gyri_sulci/SG_Outputs/' subject_name '_gy-sulc_Output/registered_csf.nii']);
csf_flip =  flip(flip(permute(csf.img,[2 1 3]),1),2);
csf_flip2 = double(csf_flip>0.2); % change

no_csf_Mu = abs(1-csf_flip2).*Mu; 

%csf_flip(csf_flip==0) = NaN;
%csf_flip(csf_flip ~= NaN) == 0; 

%Mu_no_csf = csf_flip .*Mu;
%Mu = Mu_no_csf;


lh_gry_mu = lh_gry .*no_csf_Mu;
lh_gry_mu(lh_gry_mu==0) =NaN;
lh_gry_avg=nanmean(col(lh_gry_mu))

lh_sul_mu = lh_sul .*no_csf_Mu;
lh_sul_mu(lh_sul_mu==0) =NaN;
lh_sul_avg=nanmean(col(lh_sul_mu))

rh_gry_mu = rh_gry .*no_csf_Mu;
rh_gry_mu(rh_gry_mu==0) =NaN;
rh_gry_avg=nanmean(col(rh_gry_mu))


rh_sul_mu = rh_sul .*no_csf_Mu;
rh_sul_mu(rh_sul_mu==0) =NaN;
rh_sul_avg=nanmean(col(rh_sul_mu))

if figure_on == 1 
    figure, im(lh_gry)
    figure, im(lh_sul)
    
    figure, im(lh_gry(:,:,42))
    figure, im(lh_sul(:,:,42))
    
    figure, im(rh_gry)
    figure, im(rh_sul)
    
    figure, im(rh_gry(:,:,42))
    figure, im(rh_sul(:,:,42))

    figure; im(Mu)

    figure; im(no_csf_Mu)

end