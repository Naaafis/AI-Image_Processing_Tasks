%{
===========================================================================
Aim: Decimating The Images
===========================================================================
%}


%% Basic Setup
clc; clear; close all; 

%% Setting paths
% directory containing the input images
inputimagedirectory = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/ResShift/InputImages/Original/";

% path to the directory we wanna write the decimated images
resultsdirectory = "/Users/vrsreeganesh/Desktop/BUClasses/ImageProcessing/Project/ResShift/InputImages/MatlabDownsampled/";

% files we'll be working with
files = ["baboon.png",
        "boat.png",
        "cameraman.tif",
        "fruits.png",
        "lena_color_512.tif",
        "mandril_color.tif",
        "peppers.png",
        "pirate.tif",
        "woman_blonde.tif",
        "woman_darkhair.tif"];


%% Designing the 1D filter
transitionbandwidth = 0.1;                                                 % given transition width
M = 2;                                                                     % subsampling factor
filterorder = 31;                                                          % our number of filter coefficients
endofpassband = (1/M) - transitionbandwidth/2;                             % end of passband
startofstopband = (1/M) + transitionbandwidth/2;                           % start of stop-band
filtercoefficients = firpm(filterorder-1, ...                                % designing our filters
                           [0,endofpassband, startofstopband, 1], ...
                           [1,1,0,0]);
filtercoefficients2 = repmat(filtercoefficients, [length(filtercoefficients), 1]) .* repmat(transpose(filtercoefficients), [1, length(filtercoefficients)]);


%% Going through each file
for i = 1:length(files)

    % Getting the filename
    filename = files(i);

    % reading image
    inputimage = imread(inputimagedirectory+filename);

    % filtering and downsampling
    [outputimage, typereferenceimage] = downsampleby4(inputimage, filtercoefficients2);

    % changing type saving the image
    imwrite(cast(round(outputimage), 'like', typereferenceimage), resultsdirectory +"downsampled_"+ filename);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [decimatedimage, typereferenceimage] = downsampleby4(inputimage, filtercoefficients2) 
    temp = inputimage;
    for i = 1:size(inputimage,3)
        temp(:,:,i) = filter2(filtercoefficients2, inputimage(:,:,i));
    end
    typereferenceimage = temp;
    
    % downsampling barbara after filtering
    decimatedimage = typereferenceimage(1:4:end,1:4:end,:);
end








































