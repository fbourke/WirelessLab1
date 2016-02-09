function res = process_data()
    load 'rxdata/hello'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    window = startindex:startindex+20000;
    seg = data(window);
    xs = 1:length(seg);

    SEG = fft(seg.^2);
    % figure(1)
    % plot(abs(SEG))

    [peak_amp, peak_bin] = max(abs(SEG));

    f_m = peak_bin/length(xs)*2*pi; % convert to rads/sample

    comp = exp(-j*f_m/2*xs);
    seg_demod = seg.*comp;

    % costas

    B = 4;
    Phi = zeros(size(seg_demod));
    for i = 1:length(seg_demod)-1
        v = seg_demod(i);
        e = -real(v)*imag(v);
        Phi(i+1) = Phi(i) + B*e;
    end

    size(seg_demod)
    size(Phi)
    seg_costas = seg_demod.*exp(j*Phi);
    size(seg_costas)

    figure(2)
    clf
    plot(real(seg_demod))
    hold on
    plot(real(seg_costas))
    legend('F-offset demodulated', 'Costas Demodulated')
    
    % schmitt
    % mag = 3e-3
    % thresh = .5*mag
    % filtered = schmitt(real(seg_demod), thresh, -thresh);
    % sscale = .017;

    % figure(3)
    % clf
    % plot(real(seg))
    % hold on
    % plot(real(seg_demod))
    % plot(filtered*sscale-sscale/2, 'r', 'linewidth', 2)

    % legend('Seg', 'Seg Demod', 'Schmitt Data')
end