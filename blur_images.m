%{
===========================================================================
AIM: Create Blurry Images
Note:
    We'll take in a number of standard images
    Blurr it at 3x3, 5x5, 7x7 and 11x11
===========================================================================
%}

%% Basic Setup
clc; clear; close all;

%% Getting image paths
% path to directory that contains all images
image_directory_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/ResShift/InputImages/Original";

% finding paths to files that we want to blur
filenames_in_path = fgetImagePaths(image_directory_path);
disp(filenames_in_path)

%% Designing Filter
% designing a flat 3x3 filter
filter3x3 = ones([3,3]);
filter3x3 = filter3x3/sum(filter3x3, 'all');

%% Running Images through Filter
% path to which we're writing the blurred images
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages/Blur_3x3";

for i = 1:length(filenames_in_path)
    % reading image
    inputimage00 = imread(filenames_in_path(i));

    % blurring each channel independently cause matlab doesn't support
    outputimage00 = zeros(size(inputimage00));
    for j = 1:size(outputimage00,3)
        outputimage00(:,:,j) = conv2(inputimage00(:,:,j), filter3x3, 'same');
    end

    % changing the data type
    outputimage00 = cast(outputimage00, "like", inputimage00);

    % getting the paths right
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    
    % saving image to file
    imwrite(outputimage00, outputpath00);
end

%% Designing Filter
% designing filter
filter5x5 = ones([5,5]);
filter5x5 = filter5x5/sum(filter5x5, 'all');

%% Running Images through Filter
% path to which we're writing the blurred images
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages/Blur_5x5";

for i = 1:length(filenames_in_path)
    % reading the image in
    inputimage00 = imread(filenames_in_path(i));

    % blurring each channel independently cause matlab doesn't support it
    % other wise
    outputimage00 = zeros(size(inputimage00));
    for j = 1:size(outputimage00,3)
        outputimage00(:,:,j) = conv2(inputimage00(:,:,j), filter5x5, 'same');
    end

    % changing data type
    outputimage00 = cast(outputimage00, "like", inputimage00);

    % writing path
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    
    % writing image
    imwrite(outputimage00, outputpath00);
end

%% Designing Filter
filter7x7 = ones([7,7]);
filter7x7 = filter7x7/sum(filter7x7, 'all');

%% Running Images through Filter

% the path to which the blurred images will be saved
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages/Blur_7x7";

for i = 1:length(filenames_in_path)
    % reading the images
    inputimage00 = imread(filenames_in_path(i));

    % blurring each channel independently
    outputimage00 = zeros(size(inputimage00));
    for j = 1:size(outputimage00,3)
        outputimage00(:,:,j) = conv2(inputimage00(:,:,j), filter7x7, 'same');
    end

    % changing the data type
    outputimage00 = cast(outputimage00, "like", inputimage00);

    % getting the path to the output
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    
    % saving the image
    imwrite(outputimage00, outputpath00);
end

%% Designing Filter
filter11x11 = ones([11,11]);
filter11x11 = filter11x11/sum(filter11x11, 'all');

%% Running Images through Filter
% path to which the output will be written
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages/Blur_11x11";

for i = 1:length(filenames_in_path)
    % reading the input image
    inputimage00 = imread(filenames_in_path(i));

    % blurring each channel independently cause matlab doesn't support
    outputimage00 = zeros(size(inputimage00));
    for j = 1:size(outputimage00,3)
        outputimage00(:,:,j) = conv2(inputimage00(:,:,j), filter11x11, 'same');
    end

    % changing the data type
    outputimage00 = cast(outputimage00, "like", inputimage00);

    % getting the name and path right
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    

    % saving the image
    imwrite(outputimage00, outputpath00);
    
end

%% Designing Filter
filter15x15 = ones(15);
filter15x15 = filter15x15/sum(filter15x15, 'all');

%% Running Images through Filter
% the path to which we'll be saving the images
output_path = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/BlurredImages/Blur_15x15";

for i = 1:length(filenames_in_path)
    % reading the image
    inputimage00 = imread(filenames_in_path(i));

    % blurring each channel independently
    outputimage00 = zeros(size(inputimage00));
    for j = 1:size(outputimage00,3)
        outputimage00(:,:,j) = conv2(inputimage00(:,:,j), filter15x15, 'same');
    end

    % changing the data type
    outputimage00 = cast(outputimage00, "like", inputimage00);

    % getting the name and path right
    [~, filename00, extension00] = fileparts(filenames_in_path(i));
    outputpath00 = fullfile(output_path, filename00+extension00);
    

    % saving the image
    imwrite(outputimage00, outputpath00);
    
end











%%%%%%%%%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
