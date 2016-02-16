function  out=bi2char(input)
    % requires input as 0/1
    % reshape into rows of 8 bits long
    A = padarray(input',8-mod(length(input),8),0,'post')';
    B = reshape(A,8,[])';
    % convert to decimal numbers
    C = bi2de(fliplr(B));
    % convert to char
    D = char(C);
    % convert many rows to one row
    out = reshape(D,1,[]);
end