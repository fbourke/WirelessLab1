clear all
clc

N = 64;

data = [1 (round(rand(1, N-1))-.5)*2];
Xhat = ofdm_sc_tx(data);

figure(1)
clf
plot(real(data))
hold on
plot(real(Xhat))
legend('Tx', 'Rx')