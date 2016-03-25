function [H, f_est] = ofdm_sc_hest(training)
    j = sqrt(-1);
    N = length(training);

    xtild = ifft(training);
    xtx = [training training training];

    ytild = nonflat_channel_timing_error(xtx);

    ytild = ytild(end-3*N+1:end);

    diffs = ytild(end-N+1:end)./ytild(end-2*N+1:end-N);

    f_ests = log(diffs)./(j*N);
    f_est = abs(mean(f_ests))

    ytild_f_est = ytild.*exp(-j*f_est);
    Ytild = fft(ytild_f_est)/N;

    H = Ytild./[training training training];
    H = H(end-N+1:end);
end