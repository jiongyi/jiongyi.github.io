function [backSubIm, bwIm] = dogfilter(rawIm)

% Smooth image using a rolling ball.
diskFiltIm = imfilter(rawIm, fspecial('disk', 7), 'symmetric');

% Binarize.
normIm = mat2gray(diskFiltIm);
% At least two levels are necessary to take care of multiple cells in FOV.
threshold = multithresh(normIm, 2);
seg_I = imquantize(normIm, threshold);
bwIm = seg_I ~= 1;

% Subtract background.
backSubIm = rawIm - mean(rawIm(~bwIm));
backSubIm(backSubIm < 0) = 0;
end
