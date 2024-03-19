%% Filter initialization

% Define filter specifications for a 31-coefficient FIR filter
N = 30; % Filter order (number of coefficients - 1)
wp = 0.45; % Passband edge before Nyquist frequency
ws = 0.50; % Stopband edge, allowing for a transition band
f = [0 wp ws 1]; % Frequency vector for firpm
a = [4 4 0 0]; % Amplitude specifications

% Design the filter using Parks-McClellan algorithm
b = firpm(N, f, a);

% Calculate 2-D impulse response
h2 = b'*b; % Outer product

%% Filepath specifications

% Specify the input directory containing the images to be upsampled
inputDir = '/Users/cheffbcookin/Desktop/EC520/Generative_Image_Upscaling/MatlabDecimated'; % path to decimated images
outputDir = fullfile(inputDir, '31_coef_upsampled');

% Check if the output directory exists, if not, create it
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

%% Performing Upsampling

% List and process all files in the input directory
processFiles(inputDir, outputDir, '*.png', h2); % For PNG files
processFiles(inputDir, outputDir, '*.tif', h2); % For TIF files

fprintf('Upsampling complete. Images saved to %s\n', outputDir);

%% Function to list and process files based on format
function processFiles(inputDir, outputDir, filePattern, h2)
    files = dir(fullfile(inputDir, filePattern)); 
    for i = 1:length(files)
        imgPath = fullfile(files(i).folder, files(i).name);
        [~, name, ext] = fileparts(files(i).name);
        format = ext(2:end); % Remove the dot from the extension for imwrite format
        upConvertImage(imgPath, h2, outputDir, name, format);
    end
end

%% Function to process each image
function upConvertImage(imgPath, h2, outputDir, name, format)
    img = imread(imgPath);

    % Upsample by a factor of 4 in both directions with zero insertion
    if size(img, 3) == 3 % Color image
        imgUp = zeros(4*size(img, 1), 4*size(img, 2), 3, 'like', img);
    else % Grayscale image
        imgUp = zeros(4*size(img, 1), 4*size(img, 2), 'like', img);
    end
    imgUp(1:4:end, 1:4:end, :) = img;

    % Apply the 2-D filter for upsampling
    if size(img, 3) == 3 % Color image
        for c = 1:3 % Apply to each channel
            imgUp(:,:,c) = uint8(conv2(double(imgUp(:,:,c)), h2, 'same'));
        end
    else % Grayscale image
        imgUp = uint8(conv2(double(imgUp), h2, 'same'));
    end

    % Construct the output filename with '31_coef_us' as prefix
    outputFilename = fullfile(outputDir, ['31_coef_us_' name '.' format]);
    
    % Save the image in the appropriate format
    imwrite(imgUp, outputFilename, format);
end

