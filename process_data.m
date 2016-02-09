function res = process_data()
    load 'rxdata/hello'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    window = startindex:startindex+20000;
    seg = data(window);
    xs = 1:length(seg);

    SEG = fft(seg.^2);

    figure(1)
    plot(abs(SEG))

    [peak_amp, peak_bin] = max(abs(SEG));

    scaling = 2*pi;

    f_m = peak_bin/length(xs)*2*pi; % convert to rads/sample

    comp = exp(-j*f_m/2*xs);
    seg_demod = seg.*comp;

    mag = 3e-3
    thresh = .5*mag

    filtered = schmitt(real(seg_demod), thresh, -thresh);
    sscale = .017;

    figure(2)
    clf
    plot(real(seg))
    hold on
    plot(real(seg_demod))
    plot(filtered*sscale-sscale/2, 'r', 'linewidth', 2)

    legend('Seg', 'Seg Demod', 'Schmitt Data')
end