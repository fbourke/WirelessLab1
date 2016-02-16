input = 'Hello, World! '
y = 1*ones(1,96*3); % generates vector of leading 100 values of 0.5
binary = (dec2bin(input,8)); 
binary = reshape(binary',1,[]); %moves "binary" to a single row
binary = binary - '0'; %converts binary from string to number
binary = (binary - 0.5).*2; % binary is now +1 and -1
binary = repmat(binary,1,20);
y = horzcat(y,[1,-1,-1,-1,-1,-1,-1,-1],[1,-1,-1,-1,-1,-1,-1,-1],binary,zeros(1,96*3));

pw = 16; % pulse width
out = conv(upsample(y,pw),ones(1,pw));
sample_freq = 1e6; % minimum .25 megasamples/sec
datarate = sample_freq/pw

plot(out)
legend('current');

write_usrp_data_file(out, 'data.dat')
