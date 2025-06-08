temp = load_nii('/Users/teahserani/Desktop/Gyri_sulci/FreeSurferOutputs/388_21yrOld/surf/lh_test2.nii');

colorNeg = [0, 0, 1];  % Blue for negative values
colorZero = [0, 0, 0]; % Black for zero
colorPos = [1, 0, 0];  % Red for positive values

% Number of colors in the colormap
nColors = 256;
half = floor(nColors / 2);
mid = ceil(nColors / 2);

% Generate colormap
% Negative values: blue
% Zero: black
% Positive values: red
customColormap = [linspace(colorNeg(1), colorZero(1), half)', ...
                  linspace(colorNeg(2), colorZero(2), half)', ...
                  linspace(colorNeg(3), colorZero(3), half)'; 
                  repmat(colorZero, 1, 3); % Ensure zero is exactly in the middle
                  linspace(colorZero(1), colorPos(1), nColors - half - 1)', ...
                  linspace(colorZero(2), colorPos(2), nColors - half - 1)', ...
                  linspace(colorZero(3), colorPos(3), nColors - half - 1)'];

% Ensure the colormap has exactly nColors rows
customColormap = customColormap(1:nColors, :);

% Ensure the colormap is exactly nColors rows
customColormap = customColormap(1:nColors, :);

figure; im(temp.img); colormap(customColormap)