function SNR = mimo4x4(plotting)
    N = 4;
    tlen = 100;
     
    tr = round(rand(1, tlen))*2-1;
     
    Y = zeros(N, tlen, N);
    X = zeros(N, tlen, N);
    for i = 1:N
        X(i,:,i) = tr;
        Y(:,:,i) = MIMOChannel4x4(X(:,:,i));
    end
     
    % order: row, col, cell
    % each cell represents a trial
    % cell 1 was Tx1 transmitting
     
    for i = 1:N % for each antenna (cell of Y) (row of H)
        for j = 1:N % for each training sequence
            h = Y(j,:,i)./X(i,:,i);
            H(j,i) = mean(h(~isinf(h)));
        end
    end
     
    W = inv(H');
    I = eye(N,N);

    txlen = 19;
    pw = 10;
    Xgen = round(rand(N, txlen))*2-1;
    for i = 1:N
        X2(i,:) = conv(upsample(Xgen(i,:), pw), ones(1, pw));
    end
    tlen = txlen*pw;
     
    Y2 = MIMOChannel4x4(X2);

    Xhat = W'*Y2;

    n = abs(Xhat - X2);
    SNR = mag2db(mean((abs(X2)./n)'));

    SNR = round(SNR, 3, 'significant');

    if plotting
        xpos = tlen*.8;
        ypos = -.1;
        figure(1)
        clf
        subplot(411)
        plot(real(X2(1,:)), 'linewidth', 2)
        hold on
        plot(real(Xhat(1,:)), '--', 'linewidth', 2)
        ylim([-1 1])
        t = text(xpos,ypos,['SNR: ' num2str(SNR(1)) ' dB']);
        t.FontSize = 20;
        legend('Tx data', 'Estimated Rx data')
         
        subplot(412)
        plot(real(X2(2,:)), 'linewidth', 2)
        hold on
        plot(real(Xhat(2,:)), '--', 'linewidth', 2)
        ylim([-1 1])
        t = text(xpos,ypos,['SNR: ' num2str(SNR(2)) ' dB']);
        t.FontSize = 20;

        subplot(413)
        plot(real(X2(3,:)), 'linewidth', 2)
        hold on
        plot(real(Xhat(3,:)), '--', 'linewidth', 2)
        ylim([-1 1])
        t = text(xpos,ypos,['SNR: ' num2str(SNR(3)) ' dB']);
        t.FontSize = 20;
         
        subplot(414)
        plot(real(X2(4,:)), 'linewidth', 2)
        hold on
        plot(real(Xhat(4,:)), '--', 'linewidth', 2)
        ylim([-1 1])
        t = text(xpos,ypos,['SNR: ' num2str(SNR(4)) ' dB']);
        t.FontSize = 20;
        xlabel('Sample Number')
    end
end