clear all
close all

data = read_usrp_data_file('usrp_samples.dat');

dfactor = 100

figure(1)
plot(abs(data(1:dfactor:end)))
title('Our beautiful data')
xlabel('"Sample"')
ylabel('Amplitude')

figure(2)
plot(data(1:dfactor:end))
title('Our beautiful data')
xlabel('Real')
ylabel('Imag')