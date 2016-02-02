clear all
close all

load rx2

datadown = data(1:1e3:end);
DATADOWN2 = fft(datadown.^2);

plot(abs(DATADOWN2))

[peak_amp, peak_freq] = max(abs(DATADOWN2))

Fs = .25e6;
w_m = peak_freq/2;

