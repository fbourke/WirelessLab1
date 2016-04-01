data = (round(rand(1, N))-.5)*2;
Xtild = ofdm_sc_tx(data);

j = sqrt(-1);
N = length(Xtild);

%% Generate Schmidl-Cox sequence
sc = (round(rand(1, N))-.5)*2
packet = [sc sc sc];

%% Generate channel estimation sequences
for i = 1:4
    HTR = (round(rand(1, N))-.5)*2;
    HTRs_tx(:,i) = HTR;

    htr = ifft(HTR)*sqrt(N);
    htrs(:,i) = pext(htr);
end

packet = [packet reshape(htrs, 1, []) pext(ifft(Xtild))*sqrt(N)];

write_usrp_data_file(out, 'data.dat')