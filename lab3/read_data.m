clear all
close all

data = read_usrp_data_file('rx/usrp_samples.dat');

dfactor = 1

figure(1)
plot(abs(data(1:dfactor:end)))
title('Our beautiful data')
ylim([-1e-2 1e-2])
xlabel('"Sample"')
ylabel('Amplitude')

figure(2)
plot(data(1:dfactor:end))
title('Our beautiful data')
xlabel('Real')
ylabel('Imag')