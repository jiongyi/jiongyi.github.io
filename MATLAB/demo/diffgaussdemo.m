objWidth = 2;
smallSigma = objWidth / (1 + sqrt(2));
bigSigma = objWidth * sqrt(2);
pixelNoRow = linspace(0, 10, 100);
smallGaussRow = exp(-(pixelNoRow.^2) / (2 * smallSigma^2));
bigGaussRow = exp(-(pixelNoRow.^2) / (2 * bigSigma^2));
figure('color', 'white');
plot(pixelNoRow, smallGaussRow);
hold on;
plot(pixelNoRow, bigGaussRow, 'r');
plot(pixelNoRow, smallGaussRow - bigGaussRow, 'k');
hold off;