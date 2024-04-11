%{
===========================================================================
Aim:
    Deblurring The Images
===========================================================================
%}

%% Basic Setup
clc;clear; close all;

%% Getting image paths
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages_Tinker/Blur_3x3";
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Running Images through Filter: Wiener Filtering
% filter
filter00 = ones(3);
filter00 = filter00/sum(filter00);

%% Running Images through Filter: Lucy-Richardson method **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur3x3/DeBlur3x3_LucyRechardson";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvlucy(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%% Running Images through Filter: blind deconvolution **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur3x3/DeBlur3x3_BlindDeconv";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvblind(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Getting image paths
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages_Tinker/Blur_5x5";
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Running Images through Filter: Wiener Filtering
% filter
filter00 = ones(5);
filter00 = filter00/sum(filter00);

%% Running Images through Filter: Lucy-Richardson method **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur5x5/DeBlur5x5_LucyRichardson";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvlucy(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%% Running Images through Filter: blind deconvolution **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur5x5/DeBlur5x5_BlindDeconv";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvblind(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Getting image paths
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages_Tinker/Blur_7x7";
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Running Images through Filter: Wiener Filtering
% filter
filter00 = ones(7);
filter00 = filter00/sum(filter00);

%% Running Images through Filter: Lucy-Richardson method **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur7x7/DeBlur_LucyRichardson";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvlucy(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%% Running Images through Filter: blind deconvolution **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur7x7/DeBlur_BlindDeconv";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvblind(inputimage00, filter00);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Getting image paths
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages_Tinker/Blur_11x11";
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Running Images through Filter: Wiener Filtering
% filter
filter01 = ones(11);
filter01 = filter01/sum(filter01);

%% Running Images through Filter: Lucy-Richardson method **good results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur11x11/DeBlur11x11_LucyRichardson";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvlucy(inputimage00, filter01);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%% Running Images through Filter: blind deconvolution
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur11x11/DeBlur11x11_BlindDeconv";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvblind(inputimage00, filter01);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Getting image paths
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages_Tinker/Blur_15x15";
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Running Images through Filter: Wiener Filtering
% filter
filter01 = ones(15);
filter01 = filter01/sum(filter01);

%% Running Images through Filter: Lucy-Richardson method **okay-ish results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur15x15/DeBlur15x15_LucyRichardson";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvlucy(inputimage00, filter01);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end

%% Running Images through Filter: blind deconvolution ** okay-ish results**
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/DeBlurredImages_Matlab/DeBlur15x15/DeBlur15x15_BlindDeconv";
% going through the images
for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = im2double(imread(filenames_in_path(i)));

    % deconvolving using one of the methods
    outputimage00 = deconvblind(inputimage00, filter01);

    % saving the images
    outputimage00 = cast(outputimage00, "like", inputimage00);
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    imwrite(outputimage00(20:end-20, :,:), outputpath00);

    % plotting the two
    subplot(2,1,1); imshow(inputimage00); subplot(2,1,2); imshow(outputimage00);
end


fprintf("Done \n");






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
