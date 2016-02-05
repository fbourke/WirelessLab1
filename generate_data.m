y = zeros(1,1e6);
% y(1:10000) = 0;
% y(1e5:2e5) = 1;
% y(2e5:3e5) = -1;
% y(3e5:4e5) = 1;
% y(4e5:5e5) = -1;
% y(5e5:6e5) = 1;
% y(6e5:7e5) = -1;
% y(7e5:8e5) = 1;
% y(8e5:9e5) = -1;
% y(9e5:10e5) = 1;

x = 1:1e3;
y = cos(x*pi);
pw = 30;
out = conv(upsample(y,pw),ones(1,pw));
sample_freq = 1e6; % minimum .25 megasamples/sec
datarate = sample_freq/pw

plot(out)

write_usrp_data_file(out, 'data.dat')