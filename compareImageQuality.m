% Define directories
origDir = '/Users/cheffbcookin/Desktop/EC520/Generative_Image_Upscaling/OriginalImages';
comparisonDirs = {'31_coef_upsampled', 'AI_Upsampled_Images', 'UpscalePics', 'UpscaleMedia'};
comparisonLabels = {'CoefUpsampled', 'AIUpsampled', 'UpscalePics', 'UpscaleMedia'};

% Initialize matrices for PSNR and SSIM values
psnrVals = [];
ssimVals = [];

% Initialize cell array for storing original image names
origImageNames = [];

% Loop through original images to collect their names
origFiles = dir(fullfile(origDir, '*.*')); % Assuming PNG and TIF images
for i = 1:length(origFiles)
    if origFiles(i).isdir
        continue;
    end
    origImageNames{end+1} = origFiles(i).name;
end

% Initialize PSNR and SSIM values storage
numOrigImages = length(origImageNames);
numComparisonDirs = length(comparisonDirs);
psnrVals = NaN(numOrigImages, numComparisonDirs);
ssimVals = NaN(numOrigImages, numComparisonDirs);

% Loop through each comparison directory
for d = 1:length(comparisonDirs)
    dirPath = fullfile('/Users/cheffbcookin/Desktop/EC520/Generative_Image_Upscaling', comparisonDirs{d});
    
    % For each original image, find and compare with the matched image in the current directory
    for i = 1:numOrigImages
        origImagePath = fullfile(origDir, origImageNames{i});
        origImage = imread(origImagePath);
        baseOrigName = erase(origImageNames{i}, {'.png', '.tif', '.PNG', '.TIF'});
        
        % Try to find a matching file in the comparison directory
        files = dir(fullfile(dirPath, '*.*'));
        matchFound = false;
        for j = 1:length(files)
            if contains(files(j).name, baseOrigName)
                compImagePath = fullfile(dirPath, files(j).name);
                compImage = imread(compImagePath);
                
                % Check for size and channel compatibility before computing PSNR and SSIM
                if ndims(origImage) == ndims(compImage) && all(size(origImage) == size(compImage))
                    psnrVals(i, d) = psnr(origImage, compImage);
                    ssimVals(i, d) = ssim(origImage, compImage);
                    matchFound = true;
                    break;
                end
            end
        end
        if ~matchFound
            warning('No matching image for "%s" found in "%s".', origImageNames{i}, comparisonDirs{d});
        end
    end
end

% Convert the PSNR and SSIM data into tables
psnrTable = array2table(psnrVals, 'VariableNames', comparisonLabels, 'RowNames', origImageNames);
ssimTable = array2table(ssimVals, 'VariableNames', comparisonLabels, 'RowNames', origImageNames);

% Display the tables
disp('PSNR Values:');
disp(psnrTable);

disp('SSIM Values:');
disp(ssimTable);
