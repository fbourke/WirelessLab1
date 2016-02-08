function res = process_data()
    load 'rxdata/rx5_1m'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    % window = 2.4480e6:2.4510e6;
    window = startindex:2.4510e6;
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

    filtered = schmitt(real(seg_demod), 0.002, -0.002);
    sscale = .017;

    figure(2)
    clf
    plot(real(seg))
    hold on
    plot(real(seg_demod))
    plot(filtered*sscale-sscale/2, 'r', 'linewidth', 2)

    legend('Seg', 'Seg Demod', 'Schmitt Data')

    figure(3)
    clf
    plot(real(data))
end