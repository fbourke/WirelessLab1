close all

x = 1:20;
y = cos(x*pi)+1;
pw = 400;
out = conv(upsample(y,pw), 10*ones(1,pw));
out = out + wgn(1, length(out), 1e-3);
disp 'Input length'
length(out)

index = packet_detect(out)

figure(1)
plot(out)
hold on
line([index, index], [-15, 15], 'linewidth', 2)