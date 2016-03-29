function Xhat = ofdm_sc_tx(Xtild)
    j = sqrt(-1);
    N = length(Xtild);

    %% Generate Schmidl-Cox sequence
    sc = (round(rand(1, N))-.5)*2;
    packet = [sc sc sc];

    %% Generate channel estimation sequences
    for i = 1:4
        HTR = (round(rand(1, N))-.5)*2;
        HTRs(:,i) = HTR;

        htr = ifft(HTR)*sqrt(N);
        htrs(:,i) = pext(htr);
    end

    packet = [packet reshape(htrs, 1, []) pext(ifft(Xtild))*sqrt(N)];

    %% Transmit packet
    packet_rx = nonflat_channel_timing_error(packet);
    pstart = packet_detect(packet_rx)

    %% Break up packet
    SCHMIDL_COX = packet_rx(pstart:pstart+N*3-1);

    idx = pstart+N*3;
    plen = N+N/4;

    for i = 1:4
        HTRS(:,i) = packet_rx(idx:idx+plen-1);
        idx = idx+plen;
    end

    DATA = packet_rx(idx:idx+plen-1);

    %% Estimate frequency offset
    diffs = SCHMIDL_COX(end-N-N/8+1:end-N/8)./SCHMIDL_COX(end-2*N-N/8+1:end-N-N/8);

    f_ests = log(diffs)./(j*N);
    f_est = abs(mean(f_ests))

    offset = exp(-j*f_est*N);

    %% Estimate channel
    HTRS = HTRS.*offset;
    for i = 1:4
        Yunext = fft(unpext(HTRS(:,i)))./N;
        Hests(:,i) = Yunext./HTRs(:,i);
    end

    H = mean(transpose(Hests));

    %% Process data
    DATA = DATA.*offset;

    Xhat = unpext(DATA);
    Xhat = fft(Xhat)/N./H;
end