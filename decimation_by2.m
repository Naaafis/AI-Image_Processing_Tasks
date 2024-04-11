%{
===========================================================================
Aim: Automatically downconvert images in a directory by a factor of 2
===========================================================================
%}

%% Basic Setup
clc; clear; close all;

%% Setting paths
% Directory containing the input images
inputImageDirectory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/OriginalImages"; % Update to your input directory
outputDirectorySuffix = "_Downconverted";
resultsDirectory = inputImageDirectory + outputDirectorySuffix;

% Ensure the output directory exists, if not, create it
if ~exist(resultsDirectory, 'dir')
    mkdir(resultsDirectory);
end

% Automatically list all image files in the input directory
fileStructs = dir(inputImageDirectory);
imageFiles = fileStructs(~[fileStructs.isdir]);
imageFiles = imageFiles(arrayfun(@(x) any(strcmp(x.name(end-3:end), {'.png', '.jpg', '.tif', '.jpeg'})), imageFiles));

%% Designing the 1D Filter
transitionBandwidth = 0.1;
M = 2; % Downsampling factor
filterOrder = 31;
endOfPassband = (1/M) - transitionBandwidth/2;
startOfStopband = (1/M) + transitionBandwidth/2;
filterCoefficients = firpm(filterOrder-1, [0, endOfPassband, startOfStopband, 1], [1, 1, 0, 0]);
filterCoefficients2D = filterCoefficients' * filterCoefficients;

%% Processing Each File
for i = 1:length(imageFiles)
    filename = imageFiles(i).name;
    disp(['Processing ', filename]);
    
    % Reading the image
    inputImage = imread(fullfile(inputImageDirectory, filename));
    
    % Filtering and downsampling
    [downconvertedImage, typeReferenceImage] = downconvertBy2(inputImage, filterCoefficients2D);
    
    % Saving the downconverted image
    outputFilepath = fullfile(resultsDirectory, [filename]);
    imwrite(cast(round(downconvertedImage), 'like', typeReferenceImage), outputFilepath);
end

function [downconvertedImage, typeReferenceImage] = downconvertBy2(inputImage, filterCoefficients2D)
    % Apply 2D filtering
    temp = inputImage;
    for i = 1:size(inputImage, 3)
        temp(:,:,i) = filter2(filterCoefficients2D, inputImage(:,:,i), 'same');
    end
    typeReferenceImage = temp;
    
    % Downsampling
    downconvertedImage = temp(1:2:end, 1:2:end, :);
end
