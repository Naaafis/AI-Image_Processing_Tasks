%% Basic Setup
clc; close all; clear; 

%% Filepath specifications

% Specify the input directory containing the images to be upsampled
inputDir = '/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/MatlabDownsampled'; % path to decimated images
outputDir = fullfile(inputDir, '31_coef_upsampled');

% Check if the output directory exists, if not, create it
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

%% Performing Upsampling

% List and process all files in the input directory
processFiles(inputDir, outputDir); % For PNG files

fprintf('Upsampling complete. Images saved to %s\n', outputDir);

%% Function to list and process files based on format
function processFiles(inputDir, outputDir)
    files = getImagePaths(inputDir);
    for i = 1:length(files)
        upConvertImage(files(i), outputDir);
    end
end

%% Function to process each image
function upConvertImage(imgPath, outputDir)
    img = imread(imgPath);
    
    % Building a 1D interpolator
    filterorder = 31;
    M = 4;
    transitionbandwidth = 0.18;
    endofpassband = (1/M) - transitionbandwidth/2;
    startofstopband = (1/M) + transitionbandwidth/2;
    [filtercoefficients, w] = firpm(filterorder-1, ...
                                    [0, endofpassband, startofstopband, 1], ...
                                    [4,4,0,0]);
    
    % upsampling input image
    var00 = zeros([size(img,1)*M, size(img,2)*M, size(img,3)]);
    for i = 1:size(img,3)
        var00(:,:,i) = transpose(upsample(transpose(upsample(double(img(:,:,i)), M)),M));
    end
    barbfiltereddownsampled_upsampled = var00;


    % Building a 2D interpolator
    filtercoefficients2 = repmat(filtercoefficients, [length(filtercoefficients),1]) .* repmat(transpose(filtercoefficients), [1, length(filtercoefficients)]);
    
    % filtering upsampled image
    var00 = zeros(size(barbfiltereddownsampled_upsampled));
    for i = 1:size(barbfiltereddownsampled_upsampled,3)
        var00(:,:,i) = filter2(filtercoefficients2, barbfiltereddownsampled_upsampled(:,:,i)); % you'll need to plot this
    end
    barbfiltereddownsampled_upsampled_filtered = var00;
    
    % % plot to test
    % figure(102)
    % subplot(2,4,3); imshow(cast(round(barbfiltereddownsampled_upsampled), 'like', img)); title("Decimated+Upsampled", 'FontSize',24);
    % subplot(2,4,4); imshow(cast(round(barbfiltereddownsampled_upsampled_filtered), 'like', img)); title("Decimated+Interpolated", 'FontSize',24);

    % casting to the right type
    imgUp = cast(round(barbfiltereddownsampled_upsampled_filtered), 'like', img);
    

    % Construct the output filename with '31_coef_us' as prefix
    [~, name, format] = fileparts(imgPath);
    outputFilename = fullfile(outputDir, '31_coef_us_'+ name +format);
    
    % Save the image in the appropriate format
    % imwrite(imgUp, outputFilename, format);
    imwrite(imgUp, outputFilename);
end

function imagePaths = getImagePaths(directoryPath)
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

