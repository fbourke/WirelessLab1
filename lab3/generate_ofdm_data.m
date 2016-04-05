clear all
N = 64;

data = [ -1 -1  1  1  1 -1 -1 -1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1 -1 -1 -1  1 -1 -1 -1  1  1 -1  1  1  1 -1  1  1 -1 -1 -1  1 -1 -1 -1 -1  1 -1  1 -1 -1 -1 -1  1  1 -1  1 -1  1 -1  1 -1  1];
Xtild = data;

j = sqrt(-1);
N = length(Xtild);

%% Generate Schmidl-Cox sequence
sc =  [-1  1  1  1  1  1 -1 -1  1 -1  1  1 -1 -1  1  1  1  1 -1  1 -1  1  1  1 -1  1  1 -1 -1  1  1  1  1  1 -1  1  1 -1 -1  1 -1 -1  1  1  1 -1  1 -1  1 -1  1  1 -1 -1  1 -1  1  1  1  1  1  1 -1 -1];
packet = [sc sc sc];

%% Generate channel estimation sequences

training =  [ -1 -1 -1  1 -1  1 -1 -1  1 -1 -1 -1  1  1 -1 -1  1 -1  1 -1 -1  1  1 -1  1  1  1  1  1 -1 -1 -1 -1 -1  1 -1  1  1  1 -1  1 -1 -1  1  1 -1  1 -1  1 -1  1  1  1 -1  1 -1  1  1 -1 -1  1  1  1  1 -1 -1 -1 -1 -1 -1  1  1  1  1  1 -1 -1  1 -1 -1  1 -1  1 -1  1 -1  1  1 -1 -1 -1  1  1 -1  1  1  1 -1  1 -1  1  1 -1 -1 -1  1 -1  1 -1 -1  1  1  1  1 -1 -1  1 -1  1 -1  1  1 -1 -1  1 -1 -1 -1  1 -1 -1  1 -1 -1 -1 -1  1  1  1 -1 -1  1 -1 -1 -1 -1  1 -1  1 -1 -1 -1  1  1  1 -1 -1 -1 -1 -1  1 -1  1  1 -1  1 -1 -1 -1  1  1  1 -1  1 -1  1  1  1 -1 -1  1  1 -1 -1 -1  1 -1 -1  1 -1 -1  1  1  1 -1 -1  1  1 -1 -1 -1 -1 -1 -1 -1 -1 -1  1 -1 -1  1  1 -1 -1 -1 -1  1 -1 -1  1  1 -1  1  1  1  1 -1  1 -1 -1 -1 -1 -1  1  1 -1  1 -1 -1  1 -1  1  1  1 -1 -1  1 -1  1 -1  1  1 -1  1  1  1];
training = reshape(training,4,[]);
for i = 1:4
    HTRs_tx(:,i) = training(i,:);
    htr = ifft(HTRs_tx(:,i))*sqrt(N);
    htrs(:,i) = transpose(pext(transpose(htr)));
end

packet = [packet reshape(htrs, 1, []) pext(ifft(Xtild))*sqrt(N)]./4;

out = packet
plot(real(out))

write_usrp_data_file(out, 'data.dat')