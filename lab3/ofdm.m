clear all
clc

N = 64;

training = (round(rand(1, N))-.5)*2;
[H, f_est] = ofdm_sc_hest(training);

data = (round(rand(1, N))-.5)*2;

Xhat = ofdm_sc_tx(data, H, f_est);

figure(1)
clf
plot(abs(H)*1e2)
hold on
plot(data)
plot(real(Xhat))