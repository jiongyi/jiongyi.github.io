function bwIm = markerwatershed(rawIm, objWidth)
invIm = im2double(imcomplement(mat2gray(rawIm)));
snrIm = invIm ./ imfilter(invIm, fspecial('average', 5 * objWidth), ...
    'replicate');
equalIm = adapthisteq(mat2gray(snrIm));
medianIm = medfilt2(equalIm);

structEl = strel('disk', objWidth);
erodedIm = imerode(medianIm, structEl);
openedRecIm = imreconstruct(erodedIm, medianIm);
dilatedOpenedRecIm = imdilate(openedRecIm, structEl);
openedClosedRecIm = imreconstruct(imcomplement(dilatedOpenedRecIm), ...
    imcomplement(openedRecIm));
openedClosedRecIm = imcomplement(openedClosedRecIm);

regMaxIm = imregionalmax(openedClosedRecIm);
imposedIm = imimposemin(imcomplement(medianIm), regMaxIm);
waterIm = watershed(imposedIm);
bwIm = waterIm == 0;
figure;
[m, n] = size(rawIm);
greenIm = cat(3, zeros(m, n), bwIm, zeros(m, n));
imshowpair(rawIm, greenIm, 'blend'); axis off;

end