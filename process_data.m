function res = process_data()
    load 'rxdata/hellooo'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    window = startindex:startindex+50000;
    seg = data(window);

    % costas
    seg_mag = std(seg);
    seg_w = seg/seg_mag;% important for costas loop
    B = .8;
    Phi = zeros(size(seg_w));
    v = zeros(size(seg_w));
    for i = 1:length(seg_w)-1
        v(i) = seg_w(i)*exp(j*Phi(i));
        e = -real(v(i))*imag(v(i));
        Phi(i+1) = Phi(i) + B*e;
    end

    thresh = .4*seg_mag;
    filtered = schmitt(real(v), thresh, -thresh);

    figure(2)
    clf
    plot(real(v))
    hold on
    plot(filtered-.5, 'g', 'linewidth', 2)
    legend('Costas demodulated', 'Schmitt Corrected')
end