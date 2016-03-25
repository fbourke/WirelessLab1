function packet_start = packet_detect(x)
    thresh = 5;

    i = 1;
    while 1
        if x(i+1)/x(i) > thresh
            packet_start = i;
            break
        end
        i=i+1;
    end
end