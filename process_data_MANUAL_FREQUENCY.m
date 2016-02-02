clear all
close all

load 'rxdata/rx2'

j = sqrt(-1);

data = data';
datalen = numel(data)
seg = data(4*datalen/10:5*datalen/10);
xs = 1:numel(seg);

SEG = fft(seg.^2);
% 
% figure(1)
% plot(abs(SEG))

[peak_amp, peak_freq] = max(abs(SEG))

% Fs = .25e6;

a = -0.1126;
peak_freq = 45000 + a

f_m = peak_freq/2;

comp = exp(j*f_m*xs);
seg_demod = seg.*comp;

figure(2)
plot(real(seg))
hold on
plot(real(seg_demod))
legend('Seg', 'Seg Demod')
% xlim([5.4127e5,6.9e5])