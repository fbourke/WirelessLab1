function res = process_data()
    load 'rxdata/hello'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    window = startindex:startindex+30000;
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

    % important for costas loop
    seg_w = seg/std(seg);
    B = .8;
    Phi = zeros(size(seg_w));
    v = zeros(size(seg_w));
    for i = 1:length(seg_w)-1
        v(i) = seg_w(i)*exp(j*Phi(i));
        e = -real(v(i))*imag(v(i));
        Phi(i+1) = Phi(i) + B*e;
    end

    seg_w = seg_demod/std(seg_demod);
    B = .8;
    Phi = zeros(size(seg_w));
    vfoff = zeros(size(seg_w));
    for i = 1:length(seg_w)-1
        vfoff(i) = seg_w(i)*exp(j*Phi(i));
        e = -real(vfoff(i))*imag(vfoff(i));
        Phi(i+1) = Phi(i) + B*e;
    end

    % schmitt
    % mag = 3e-3
    % thresh = .5*mag
    % filtered = schmitt(real(seg_costas), thresh, -thresh);
    % sscale = .017;

    figure(2)
    clf
    plot(real(seg_demod))
    hold on
    plot(real(v))
    plot(real(vfoff))
    legend('Original signal', 'Costas demodulated', 'F-offset and Costas demodulated')

    % figure(3)
    % clf
    % plot(real(seg))
    % hold on
    % plot(real(seg_costas))
    % plot(filtered*sscale-sscale/2, 'r', 'linewidth', 2)

    % legend('Seg', 'Seg Demod', 'Schmitt Data')
end