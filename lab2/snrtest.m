clear all;
clc;

trials = 40;
for i = 1:trials
    mimo4x4s(i,:) = mimo4x4(0);
    svd4x4s(i,:) = svd4x4(0);
end

mimosnr = mean(mimo4x4s)
svdsnr = mean(svd4x4s)

ratio = svdsnr./mimosnr