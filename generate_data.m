input = 'Hello, World! '
y = 1*ones(1,96); % generates vector of leading 100 values of 0.5
binary = (dec2bin(input,8)); 
binary = reshape(binary',1,[]); %moves "binary" to a single row
binary = binary - '0'; %converts binary from string to number
binary = (binary - 0.5).*2; % binary is now +1 and -1
binary = repmat(binary,1,20);
y = horzcat(y,[1,-1,-1,-1,-1,-1,-1,-1],[1,-1,-1,-1,-1,-1,-1,-1],binary);

pw = 30; % pulse width
out = conv(upsample(y,pw),ones(1,pw));
sample_freq = 1e6; % minimum .25 megasamples/sec
datarate = sample_freq/pw

% x = 1:1e3;
% y = cos(x*pi); % generates vector of alternating 1 and -1
% out2 = conv(upsample(y,pw),ones(1,pw));

% plot(out)
% hold all
% plot(out2,'linewidth',2)
% legend('current','working');

write_usrp_data_file(out, 'data.dat')

%%
% for offset = 1:20 

%     A = horzcat(y((8*11+offset+1):end), ones(1,offset));
    A = (input(1:end)+1)./2
    B = reshape(A,8,[])'
    C = bi2de(fliplr(B));
    D = char(C);
    E = reshape(D,1,[])
% end