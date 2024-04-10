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
originaldirectorypath = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/OriginalImages";
processeddirectorypath = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur15x15/DeBlur15x15_BlindDeconv";

%% Calculating mse, psnr and ssim list
[mselist00, psnrlist00, ssimlist00] = fCalculateMatrics(originaldirectorypath, processeddirectorypath);





%% Functions
function [mselist, psnrlist, ssimlist] = fCalculateMatrics(originaldirectorypath, processeddirectorypath)
    
    %% Reading files and calculating SSIM and PSNR
    filenames_in_path = fgetImagePaths(processeddirectorypath);
    mselist = []; psnrlist = [];ssimlist = []; 
    for i = 1:length(filenames_in_path)
        % reading image
        inputimage00 = im2double(imread(filenames_in_path(i)));
        [~, filename01, extension01] = fileparts(filenames_in_path(i));
    
        % reading original image
        inputimage01 = im2double(imread(fullfile(originaldirectorypath, filename01+extension01)));
        % inputimage01 = inputimage01(20:end-20,:,:); % done cause the processed image wasn't the exact same dimensions
    
        % % plotting the images
        % subplot(2,1,1); imshow(inputimage00);
        % subplot(2,1,2); imshow(inputimage01);
    
        % calculating MSE
        mse00 = mean((inputimage00 - inputimage01).^2, 'all');
    
        % appending to larger list
        mselist = [mselist; mse00];
    
        % appending to larger list
        psnrlist = [psnrlist; psnr(inputimage00, inputimage01)];
    
        % calculating SSIM values between the two
        ssimlist = [ssimlist; ssim(inputimage00, inputimage01)];
    
    end

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
