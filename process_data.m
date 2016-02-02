clear all
close all

load 'rxdata/rx2'

j = sqrt(-1);

data = data';
datalen = numel(data)
seg = data(datalen/2:5*datalen/6);
xs = 1:numel(seg);

SEG = fft(seg.^2);

figure(1)
plot(abs(SEG))

[peak_amp, peak_freq] = max(abs(SEG))

% Fs = .25e6;
f_m = peak_freq/2;

comp = exp(j*f_m*xs);
seg_demod = seg.*comp;

figure(2)
plot(real(seg))
hold on
plot(real(seg_demod))
legend('Seg', 'Seg Demod')