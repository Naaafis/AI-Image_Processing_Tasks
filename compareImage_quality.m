%{
===========================================================================
Aim: 
    Calculate MSE, PSNR and SSIM
Note:
    This code works under the assumption that the name of the files in the
    original path and processed paths are the same
    
===========================================================================
%}

%% Basic Setup
clc; close all; clear;

%% Define directories
originaldirectorypath = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/OriginalImages_PNG/";
processeddirectorypath = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/UpconvertingTask/AI_Upsampled_Images";

%% Calculating mse, psnr and ssim list
% [mselist00, psnrlist00, ssimlist00] = fCalculateMatrics(originaldirectorypath, processeddirectorypath);

[mselist00, psnrlist00, ssimlist00, resultsTable] = fCalculateMatrics(originaldirectorypath, processeddirectorypath);

%% Display the results table
disp(resultsTable);



%% Functions

function [mselist, psnrlist, ssimlist, resultsTable] = fCalculateMatrics(originaldirectorypath, processeddirectorypath)
    
    %% Reading files and calculating SSIM and PSNR
    filenames_in_path = fgetImagePaths(processeddirectorypath);
    mselist = []; psnrlist = []; ssimlist = []; 
    filenames = {}; % Initialize an empty cell array for filenames
    
    for i = 1:length(filenames_in_path)
        % reading image
        inputimage00 = im2double(imread(filenames_in_path(i)));
    
        % Ensure the image has three channels
        if size(inputimage00, 3) == 1
            inputimage00 = repmat(inputimage00, [1, 1, 3]);
        end
        
        [~, filename01, extension01] = fileparts(filenames_in_path(i));
        filenames{i} = filename01; % Store the filename for table
        
        % reading original image
        inputimage01 = im2double(imread(fullfile(originaldirectorypath, filename01+extension01)));
    
        % Ensure the original image has three channels
        if size(inputimage01, 3) == 1
            inputimage01 = repmat(inputimage01, [1, 1, 3]);
        end

        % calculating MSE
        mse00 = mean((inputimage00 - inputimage01).^2, 'all');
        mselist = [mselist; mse00];
    
        % calculating PSNR
        psnrlist = [psnrlist; psnr(inputimage00, inputimage01)];
    
        % calculating SSIM
        ssimlist = [ssimlist; ssim(inputimage00, inputimage01)];
    end
    
    % Create a table from the collected metrics and filenames
    resultsTable = table(filenames', mselist, psnrlist, ssimlist, ...
                         'VariableNames', {'Filename', 'MSE', 'PSNR', 'SSIM'});
end


function imagePaths = fgetImagePaths(directoryPath)
    % List all files in the directory
    files = dir(directoryPath);
    
    % Initialize an empty cell array to store image paths
    imagePaths = [];
    
    % Iterate through each file in the directory
    for i = 1:length(files)
        % Check if the file is an image (by checking the extension)
        [~, ~, ext] = fileparts(files(i).name);
        % List of common image extensions
        imageExtensions = {'.jpg', '.jpeg', '.png','.tif', '.gif', '.bmp'};
        
        % If the file has a valid image extension, add its full path to the imagePaths array
        if any(strcmpi(ext, imageExtensions))
            % Concatenate the directory path and file name to get the full path
            imagePath = fullfile(directoryPath, files(i).name);
            % Add the full path to the imagePaths array
            imagePaths = [imagePaths; string(imagePath)];
        end
    end
end


