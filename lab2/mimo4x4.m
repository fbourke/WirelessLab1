clear all;
 
N = 4;
tlen = 1000;
 
tr = round(rand(1, tlen))*2-0.5;
 
Y = zeros(4, tlen, 4);
X = zeros(4, tlen, 4);
for i = 1:N
    X(i,:,i) = tr;
    Y(:,:,i) = MIMOChannel4x4(X(:,:,i));
end
 
% order: row, col, cell
% each cell represents a trial
% cell 1 was Tx1 transmitting
 
for i = 1:N % for each antenna (cell of Y) (row of H)
    for j = 1:N % for each training sequence
        h = Y(j,:,i)./X(i,:,i);
        H(j,i) = mean(h(~isinf(h)));
    end
end
 
W = inv(H');
I = eye(N,N);
 
txlen = 19;
pw = 10;
Xgen = round(rand(4, txlen));
for i = 1:N
    X2(i,:) = conv(upsample(Xgen(i,:), pw), ones(1, pw));
end
 
Y2 = MIMOChannel4x4(X2);

Xhat = W'*Y2;
 
figure
subplot(411)
plot(real(X2(1,:)), 'linewidth', 2)
hold on
plot(real(Xhat(1,:)), '--', 'linewidth', 2)
 
subplot(412)
plot(real(X2(2,:)), 'linewidth', 2)
hold on
plot(real(Xhat(2,:)), '--', 'linewidth', 2)
 
subplot(413)
plot(real(X2(3,:)), 'linewidth', 2)
hold on
plot(real(Xhat(3,:)), '--', 'linewidth', 2)
 
subplot(414)
plot(real(X2(4,:)), 'linewidth', 2)
hold on
plot(real(Xhat(4,:)), '--', 'linewidth', 2)