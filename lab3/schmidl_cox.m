function f_est = schmidl_cox(y)
    j = sqrt(-1);
    M = length(y)/3;

    diffs = y(2*M:3*M)./y(M:2*M);

    f_ests = log(diffs)./(j*M);

    f_est = mean(f_ests);
end