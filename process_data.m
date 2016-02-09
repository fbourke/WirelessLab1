function res = process_data()
    load 'rxdata/hellooo'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    window = startindex:startindex+50000;
    seg = data(window);

    % costas
    seg_w = seg/std(seg);% important for costas loop
    B = .8;
    Phi = zeros(size(seg_w));
    v = zeros(size(seg_w));
    for i = 1:length(seg_w)-1
        v(i) = seg_w(i)*exp(j*Phi(i));
        e = -real(v(i))*imag(v(i));
        Phi(i+1) = Phi(i) + B*e;
    end

    vmag = std(v);
    thresh = .7*vmag;
    vfilt = schmitt(real(v), thresh, -thresh);

    pw = 30;
    edges = diff(vfilt);
    edges = edges(edges>0);
    istart = edges(1)+pw/2;

    bits = vfilt(istart:pw:end)

    save hellooo_processed

    figure(2)
    clf
    plot(real(v))
    hold on
    plot(vfilt*vmag-vmag/2, 'g', 'linewidth', 2)
    legend('Costas demodulated', 'Schmitt Corrected')
end