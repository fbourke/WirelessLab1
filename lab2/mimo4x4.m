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
plot(abs(reshape(Y(1,:,:),[],size(Y(1,:,:),2),1)))
hold on
plot(abs(reshape(Y(2,:,:),[],size(Y(1,:,:),2),1)))
plot(abs(reshape(Y(3,:,:),[],size(Y(1,:,:),2),1)))
plot(abs(reshape(Y(4,:,:),[],size(Y(1,:,:),2),1)))
legend('y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4', 'y1', 'y2', 'y3', 'y4')