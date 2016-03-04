clear all;

N = 4;
tlen = 100;

tr = round(rand(1, tlen));

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

txlen = 10;
pw = 5;
Xgen = round(rand(4, txlen));
for i = 1:N
    X2(i,:) = conv(upsample(Xgen(i,:), pw), ones(1, pw));
end

[U, S, V] = svd(H);

X2t = V*X2;
Y2 = MIMOChannel4x4(X2t);
Xhat = inv(S)*U'*Y2;

N = abs(Xhat - X2);
SNR = mean((abs(X2)./N)');
mag2db(SNR)
 
figure(1)
clf
subplot(411)
plot(real(X2(1,:)), 'linewidth', 2)
hold on
plot(real(Xhat(1,:)), '--', 'linewidth', 2)
ylim([0 1])
 
subplot(412)
plot(real(X2(2,:)), 'linewidth', 2)
hold on
plot(real(Xhat(2,:)), '--', 'linewidth', 2)
ylim([0 1])

subplot(413)
plot(real(X2(3,:)), 'linewidth', 2)
hold on
plot(real(Xhat(3,:)), '--', 'linewidth', 2)
ylim([0 1])
 
subplot(414)
plot(real(X2(4,:)), 'linewidth', 2)
hold on
plot(real(Xhat(4,:)), '--', 'linewidth', 2)
ylim([0 1])