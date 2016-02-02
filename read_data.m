clear all;

data = read_usrp_data_file('usrp_samples.dat');

figure(1)
plot(abs(data(1:1000:end)))
title('Our beautiful data downsampled 1000x')
xlabel('Sample/1000')
ylabel('Amplitude')

figure(2)
plot(data(1:1000:end))
title('Our beautiful data downsamples 1000x')
xlabel('Real')
ylabel('Imag')