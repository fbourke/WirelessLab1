function Xhat = ofdm_sc_tx(Xtild)
    j = sqrt(-1);
    N = length(Xtild);

    %% Generate Schmidl-Cox sequence
    sc = (round(rand(1, N))-.5)*2;
    packet = [sc sc sc];

    %% Generate channel estimation sequences
    for i = 1:4
        HTR = (round(rand(1, N))-.5)*2;
        HTRs_tx(:,i) = HTR;

        htr = ifft(HTR)*sqrt(N);
        htrs(:,i) = pext(htr);
    end

    packet = [packet reshape(htrs, 1, []) pext(ifft(Xtild))*sqrt(N)];

    %% Transmit packet
    packet_rx = nonflat_channel_timing_error(packet);
    % pstart = 8;
    % pstart = packet_detect(packet_rx)
    pstart = find_start_point_cox_schmidl(packet_rx(N:end), N);

    %% Get Schmidl-Cox section of packet
    SCHMIDL_COX = packet_rx(pstart:pstart+N*3-1);

    %% Estimate and apply frequency offset
    set_back = N/8;
    diffs = SCHMIDL_COX(end-N-set_back+1:end-set_back)./SCHMIDL_COX(end-2*N-set_back+1:end-N-set_back);

    f_ests = log(diffs)./(j*N);
    f_est = abs(mean(f_ests))

    offset = exp(-j*f_est*[1:length(packet_rx)]);

    packet_rx = packet_rx.*offset;

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

    %% Process data
    Xhat = unpext(DATA);

    Xhat = fft(Xhat)/N./H;
end