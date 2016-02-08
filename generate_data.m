input = 'Hello, World!'
y = zeros(1,100); % generates vector of leading 100 zeros
binary = (dec2bin(input,8)); 
binary = binary(:)'-'0'; %moves 'binary' to a single row
binary = (binary - 0.5).*2; % binary is now +1 and -1
y = horzcat(y,binary);

% y = zeros(1,1e6);
% x = 1:1e3;
% y = cos(x*pi); % generates vector of alternating 1 and -1
pw = 30; % pulse width
out = conv(upsample(y,pw),ones(1,pw));
sample_freq = 1e6; % minimum .25 megasamples/sec
datarate = sample_freq/pw

plot(out)

write_usrp_data_file(out, 'data.dat')