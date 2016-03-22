clear all
close all
clc

N = 64;

training = [1 1 -1 1 1 -1 -1 1 1 1 -1 1 1 -1 1 -1 -1 1 1 1 1 -1 1 1 1 1 1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 1 1 1 -1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 1 1];

data = (round(rand(1, N))-.5)*2

Xtild = training;
xtild = ifft(Xtild);

xtx = [xtild(N-15:N) xtild];

ytild = nonflat_channel(xtx);
ytild = ytild(17:N+16);

Ytild = fft(ytild)/N;

H = Ytild./Xtild;

Xhat = ofdm_tx(data, H);

figure(1)
plot(data)
hold on
plot(real(Xhat))