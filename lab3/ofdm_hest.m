function H = ofdm_hest(training)
    N = length(training);

    xtild = ifft(training);
    xtx = [xtild(N-15:N) xtild];

    ytild = nonflat_channel_timing_error(xtx);
    ytild = ytild(17:N+16);

    Ytild = fft(ytild)/N;

    H = Ytild./training;
end