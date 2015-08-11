function plotorientation(CellStatsCell)
orientationDegCell = cellfun(@(x) [x(:).Orientation], CellStatsCell, ...
    'UniformOutput', false);
cosOrientationCell = cellfun(@cos, orientationDegCell, ...
    'UniformOutput', false);
meanCosOrientationRow = cellfun(@mean, cosOrientationCell);

orientationAbsDegCell = cellfun(@abs, orientationDegCell, ...
    'UniformOutput', false);
binRow = linspace(0, 90, 6);
binCountCell = cellfun(@(x) hist(x, binRow), orientationAbsDegCell, ...
    'UniformOutput', false);
normBinCountCell = cellfun(@(x) x / sum(x), binCountCell, ...
    'UniformOutput', false);
normBinCountMat = vertcat(normBinCountCell{:})';
figure('color', 'w');
imshow(normBinCountMat, 'InitialMagnification', 'fit');
colormap jet;

figure('color', 'w');
plotSpread(orientationDegCell);
set(gca, 'box', 'off', 'tickdir', 'out', 'linewidth', 1.5);
xlabel('Frame No');
ylabel('Orientation (rad)');

figure('color', 'w');
plot(meanCosOrientationRow);
set(gca, 'box', 'off', 'tickdir', 'out', 'linewidth', 1.5);
xlabel('Frame No');
ylabel('Mean cosine of orientation');
end