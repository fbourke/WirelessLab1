function Xhat = ofdm_sc_tx_test(Xtild)
    load ofdm_data

    j = sqrt(-1);
    N = length(Xtild);

    %% Transmit packet
    packet_rx = nonflat_channel_timing_error(packet);
    % pstart = 8;
    % pstart = packet_detect(packet_rx)
    pstart = find_start_point_cox_schmidl(packet_rx(N:end), N);

    %% Get Schmidl-Cox section of packet
    SCHMIDL_COX = packet_rx(pstart:pstart+N*3-1);

    packet_rx = schmidl_cox(SCHMIDL_COX, packet_rx, N);

    %% Get training sequences and data

    idx = pstart+N*3;
    plen = N+N/4;

    for i = 1:4
        HTRs_rx(:,i) = packet_rx(idx:idx+plen-1);
        idx = idx+plen;
    end

    DATA = packet_rx(idx:idx+plen-1);

    %% Estimate channel
    for i = 1:4
        Yunext = fft(unpext(HTRs_rx(:,i)))./N;
        Hests(:,i) = Yunext./HTRs_tx(:,i);
    end

    H = mean(transpose(Hests));

    figure(2)
    plot(real(H))

    figure(1)
    clf
    plot(real(data))
    hold all

    %% Process data
    Xhat = unpext(DATA);

    Xhat = fft(Xhat)/N./H;
end