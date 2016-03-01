function  out=schmitt(x, h_thresh, l_thresh)
% auto assign thresholds if no arguments given
if nargin < 2
   h_thresh = 0.1;
end
if nargin < 3
   l_thresh = -h_thresh;
end

state = 1;
out = zeros(1,length(x));
for i = 1:length(x)
    if state == 0
        if x(i) > h_thresh
            state = 1;
        end
    else if state == 1
        if x(i) < l_thresh
            state = 0;
        end
    end
    out(i) = state;
end
end