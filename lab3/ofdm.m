clear all
clc

N = 64;

data = (round(rand(1, N))-.5)*2;
Xhat = ofdm_sc_tx_test(data);

figure(1)
plot(real(Xhat))
legend('Tx', 'Rx')