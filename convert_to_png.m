%% Setup
clc; clear; close all;

% Specify the input directory containing images
inputDir = '/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/OriginalImages'; 

% Specify the output directory for PNG images
outputDir = '/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/OriginalImages_PNG'; 

% Check if the output directory exists; if not, create it
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

%% Processing
% List all files in the directory
files = dir(inputDir);
% Filter to include only files (exclude directories)
files = files(~[files.isdir]);

% Loop through each file
for i = 1:length(files)
    [~, name, ~] = fileparts(files(i).name); % Extract file name without extension
    
    % Full path to the current file
    currentFilePath = fullfile(files(i).folder, files(i).name);
    
    % Try to read the image (this will skip non-image files)
    try
        image = imread(currentFilePath);
        % Full path for the output PNG file
        outputFilePath = fullfile(outputDir, strcat(name, '.png'));
        % Save the image as PNG
        imwrite(image, outputFilePath);
        fprintf('Converted and saved: %s\n', outputFilePath);
    catch ME
        % If an error occurs (likely because the file isn't an image), skip it
        fprintf('Skipping: %s (Error: %s)\n', files(i).name, ME.message);
    end
end
