function res = process_data()
    load 'rxdata/processed24'

    j = sqrt(-1);

    data = data';
    startindex = packet_detect(data)

    pw = 24;
    window = startindex+200*pw:startindex+20000;
    seg = data(window);

    % costas
    seg = seg/std(seg);
    seg_w = seg/std(seg);% important for costas loop
    B = .8;
    Phi = zeros(size(seg_w));
    v = zeros(size(seg_w));
    for i = 1:length(seg_w)-1
        v(i) = seg_w(i)*exp(j*Phi(i));
        e = -real(v(i))*imag(v(i));
        Phi(i+1) = Phi(i) + B*e;
    end

    if v(1) < 0
        v = -v;
    end
    vmag = std(v);
    thresh = .7*vmag;
    vfilt = schmitt(real(v), thresh, -thresh);

    vdiff = diff(vfilt);
    edge1 = find(vdiff, 1);
    % 15 for the training sequence
    istart = edge1+15*pw+pw/2;

    bits = vfilt(istart:pw:end);

    bi2char(bits)

    save 'rxdata/processed'

    figure(2)
    clf
    plot(real(v))
    hold on
    plot(vfilt*vmag-vmag/2, 'g', 'linewidth', 2)
    legend('Costas demodulated', 'Schmitt Corrected')
end