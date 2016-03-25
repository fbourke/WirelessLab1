function Xhat = ofdm_tx(Xtild, H)
    N = length(Xtild);

    xtild = ifft(Xtild);
    xtx = [xtild(N-15:N) xtild];

    ytild = nonflat_channel_timing_error(xtx);
    ytild = ytild(17:N+16);

    Ytild = fft(ytild)/N;

    Xhat = Ytild./H;
end