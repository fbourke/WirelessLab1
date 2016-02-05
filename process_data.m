clear all
close all

load 'rxdata/rx3'

j = sqrt(-1);

data = data';
datalen = numel(data)
seg = data;
seglen = numel(seg)
xs = 1:numel(seg);

SEG = fft(seg.^2);

figure(1)
plot(abs(SEG))

[peak_amp, peak_bin] = max(abs(SEG))

f_m = peak_bin/numel(xs)*2*pi; % convert to rads/sample

comp = exp(-j*f_m/2*xs);
seg_demod = seg.*comp;

figure(2)
plot(real(comp))

figure(3)
plot(real(seg))
hold on
plot(real(seg_demod))
legend('Seg', 'Seg Demod')