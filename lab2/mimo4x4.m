clear all;

N = 4;
tlen = 200;

tr = round(rand(1, tlen));

Y = zeros(4, tlen, 4);
x = zeros(4, tlen);
for i = 1:N
    x = zeros(4, tlen);
    x(i, :) = tr;
    Y(:,:, i) = MIMOChannel4x4(x);
end

figure
clf
plot(real(Y(:,:,1)))
hold on
plot(real(Y(:,:,2)))
plot(real(Y(:,:,3)))
plot(real(Y(:,:,4)))
legend('y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4')