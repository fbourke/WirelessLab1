clear all
clc

N = 64;

for i = 1:2*N
    training = (round(rand(1, N))-.5)*2;
    Hests(i,:) = ofdm_hest(training);
end

data = (round(rand(1, N))-.5)*2;

H = mean(Hests);

Xhat = ofdm_tx(data, H);

figure(1)
clf
plot(abs(H)*1e2)
hold on
plot(data)
plot(real(Xhat))