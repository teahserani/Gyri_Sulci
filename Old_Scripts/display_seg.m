temp = load_nii('/Users/teahserani/Desktop/Gyri_sulci/FreeSurferOutputs/388_21yrOld/surf/lh_test2.nii');
% Define the number of colors in the colormap
n = 3; % Number of colors in the colormap

% Create a colormap with red and blue endpoints
% Create a matrix where the first column is blue and the last column is red
cmap = [linspace(0, 1, n)' zeros(n, 1) linspace(1, 0, n)'];

% Create some sample data for demonstration
data = rand(10, 10) * 100; % Example data ranging from 0 to 100

% Plot the data
imagesc(data);
colorbar;

% Set the colormap
colormap(cmap);

% Set color limits
caxis([0 100]); % Adjust as needed to match your data range


