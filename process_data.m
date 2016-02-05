function res = process_data()
    load 'rxdata/rx4'

    function packet_start = packet_detect(x)
        dfactor = 100;
        xd = x(1:dfactor:end); % downsample for speed
        nloops = 1000;
        thresh = 1.1;

        packet_start = 1;

        win_len = floor(length(xd)/nloops)
        win_l = 1:win_len;
        win_r = win_len:2*win_len;

        for i = 1:nloops
            l_pow = pwelch(xd(win_l));
            r_pow = pwelch(xd(win_r));

            if r_pow/l_pow > thresh
                packet_start = i*dfactor;
                break
            end

            win_l = win_l+win_len;
            win_r = win_r+win_len;
        end
    end


    j = sqrt(-1);

    data = data';
    datalen = length(data)
    seg = data;
    seglen = length(seg)
    xs = 1:length(seg);

    SEG = fft(seg.^2);

    figure(1)
    plot(abs(SEG))

    [peak_amp, peak_bin] = max(abs(SEG))

    scaling = 2*pi;

    f_m = peak_bin/length(xs)*2*pi; % convert to rads/sample

    comp = exp(-j*f_m/2*xs);
    seg_demod = seg.*comp;

    filtered = schmitt(real(seg_demod(window(1):window(end))),0.002,-0.002);

    figure(2)
    plot(real(seg))
    hold on
    plot(real(seg_demod))
    legend('Seg', 'Seg Demod')
end