function xext = pext(x)
    N = length(x);
    
    xext = [x(N-N/4+1:N) x];
end