function Xhat = ofdm_sc_tx(Xtild, H, f_est)
    j = sqrt(-1);
    N = length(Xtild);

    xtild = ifft(Xtild);
    xtx = [xtild(N-15:N) xtild];

    ytild = nonflat_channel_timing_error(xtx);
    ytild = ytild(17:N+16);

    ytild = ytild.*exp(-j*f_est);
    Ytild = fft(ytild)/N;

    Xhat = Ytild./H;
end