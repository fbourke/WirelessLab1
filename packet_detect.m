function packet_start = packet_detect(x)
    dfactor = 100;
    xd = x(1:dfactor:end); % downsample for speed

    % window should smaller than/fairly close to the width of a pulse
    win_len = 2000/dfactor;
    step = floor(win_len);
    nloops = floor((length(x) - win_len*2)/(step+1));

    win_l = 1:win_len;
    win_r = win_len:2*win_len;

    thresh = 100;

    packet_start = 1;

    for i = 1:nloops
        l_pow = mean(pwelch(xd(win_l)));
        r_pow = mean(pwelch(xd(win_r)));

        if r_pow/l_pow > thresh
            packet_start = i*win_len*dfactor;
            break
        end

        win_l = win_l+step;
        win_r = win_r+step;
    end
end