function corrected = schmidl_cox(training, packet_in, N)
    j = sqrt(-1);
    %% Estimate and apply frequency offset
    set_back = N/8;
    diffs = training(end-N-set_back+1:end-set_back)./training(end-2*N-set_back+1:end-N-set_back);

    f_ests = angle(diffs)/N;
    f_est = abs(mean(f_ests));

    offset = exp(-j*f_est*[1:length(packet_in)]);

    corrected = packet_in.*offset;
end