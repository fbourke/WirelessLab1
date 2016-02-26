clear all;

N = 4;
tlen = 10;

tr = round(rand(1, tlen));

Y = zeros(4, tlen, 4);
x = zeros(4, tlen);
for i = 1:N
    x = zeros(4, tlen);
    x(i, :) = tr;
    Y(:,:, i) = MIMOChannel4x4(x);
end

tr
Y