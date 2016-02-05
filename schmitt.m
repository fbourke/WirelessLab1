function  out=schmitt(x, h_thresh, l_thresh)
state = 1;
out = zeros(1,length(x));
for i = 1:length(x)
    if state == 1
        if x(i) < l_thresh
            state = 0;
        end
    end
    if state == 0
        if x(i) > h_thresh
            state = 1;
        end
    end
    out(i) = state;
end
end