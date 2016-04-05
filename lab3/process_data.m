function res = process_data()
    j = sqrt(-1);
    data = read_usrp_data_file('rx/usrp_samples.dat');
    data_tx = [ -1 -1  1  1  1 -1 -1 -1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1 -1 -1 -1  1 -1 -1 -1  1  1 -1  1  1  1 -1  1  1 -1 -1 -1  1 -1 -1 -1 -1  1 -1  1 -1 -1 -1 -1  1  1 -1  1 -1  1 -1  1 -1  1];

    N = 64;
    training =  [ 1 -1  1  1  1  1  1  1 -1 -1 -1 -1  1  1 -1  1 -1 -1 -1 -1 -1 -1  1  1  1  1 -1 -1  1 -1  1  1 -1  1 -1  1  1 -1 -1  1  1  1  1  1  1  1  1 -1 -1 -1  1  1  1 -1  1 -1  1 -1  1  1 -1  1 -1 -1  1 -1 -1 -1  1  1  1 -1 -1  1 -1 -1 -1 -1  1  1 -1 -1 -1 -1  1 -1  1 -1 -1  1  1 -1  1  1  1 -1 -1 -1 -1 -1 -1 -1  1 -1  1  1 -1  1  1  1 -1 -1 -1 -1 -1  1 -1 -1 -1 -1  1 -1 -1 -1  1 -1  1  1 -1  1 -1  1  1  1 -1 -1 -1  1  1  1 -1  1  1 -1  1 -1  1  1 -1  1  1 -1 -1  1 -1  1  1 -1  1  1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1  1  1  1 -1  1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1 -1  1 -1  1  1  1  1 -1 -1 -1  1  1 -1  1  1 -1 -1 -1  1  1 -1  1 -1  1  1  1  1 -1  1 -1 -1  1 -1 -1  1 -1  1 -1 -1  1  1 -1 -1 -1  1 -1 -1  1  1  1 -1  1  1  1  1 -1  1 -1 -1 -1 -1 -1  1  1 -1 -1 -1 -1];
    HTRs_tx = reshape(training,4,[])';

    data = transpose(data);
    startindex = 957318;

    window = startindex:startindex+600;
    packet = data(window);

    pstart = 1;

    %% Get Schmidl-Cox section of packet
    SCHMIDL_COX = packet(pstart:pstart+N*3-1);
    size(SCHMIDL_COX)

    packet = schmidl_cox(SCHMIDL_COX, packet, N);
    size(packet)

    %% Get training sequences and data

    idx = N*3;
    plen = N+N/4;

    for i = 1:4
        HTRs_rx(:,i) = packet(idx:idx+plen-1);
        idx = idx+plen;
    end

    DATA = packet(idx:idx+plen-1);

    %% Estimate channel
    for i = 1:4
        Yunext = fft(unpext(HTRs_rx(:,i)))./N;
        Hests(:,i) = Yunext./HTRs_tx(:,i);
    end

    H = mean(transpose(Hests));

    figure(2)
    plot(real(H))

    %% Process data
    Xhat = unpext(DATA);

    Xhat = fft(Xhat)/N./H;

    figure(2)
    clf
    hold on
    plot(-real(Xhat))
    plot(real(data_tx))
end