clear all

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

% a = -0.1126; % 3e5 to 4e5
% a = -0.11265; % 2e5 to 3e5
% a = -0.11255; % 4e5 to 5e5
% a = -0.11252; % 5e5 to 6e5
 a = -0.11285; % 0e5 to 2e5
peak_freq = 45000 + a
f_m = peak_freq/2;
comp = exp(j*f_m*xs(1:2e5));
seg_demod(1:2e5) = seg(1:2e5).*comp;

a = -0.11265; % 2e5 to 3e5
range = 2e5:3e5;
peak_freq = 45000 + a;
f_m = peak_freq/2;
comp = exp(j*f_m*xs(range));
seg_demod(range) = seg(range).*comp;

a = -0.1126; % 3e5 to 4e5
range = 3e5:4e5;
peak_freq = 45000 + a;
f_m = peak_freq/2;
comp = exp(j*f_m*xs(range));
seg_demod(range) = seg(range).*comp;

a = -0.11255; % 4e5 to 5e5
range = 4e5:5e5;
peak_freq = 45000 + a
f_m = peak_freq/2;
comp = exp(j*f_m*xs(range));
seg_demod(range) = seg(range).*comp;

a = -0.11252; % 5e5 to 6e5
range = 5e5:7e5;
peak_freq = 45000 + a
f_m = peak_freq/2;
comp = exp(j*f_m*xs(range));
seg_demod(range) = seg(range).*comp;

figure(2);
clf;
plot(real(seg))
hold on
plot(real(seg_demod))
legend('Seg', 'Seg Demod')
% xlim([0,2e5])