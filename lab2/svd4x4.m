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

X2tild = V*X2;
Y2 = MIMOChannel4x4(X2);

Xhat = U'*Y2;

figure
plot(real(X2(1,:)), 'linewidth', 2)
hold on
% plot(real(X2tild(1,:)), 'linewidth', 2)
plot(real(Xhat(1,:)), '--', 'linewidth', 2)
% plot(Xfilt(1,:), '--', 'linewidth', 2)

% plot(real(X2(2,:)), 'linewidth', 2)
% plot(real(X2tild(2,:)), 'linewidth', 2)
% plot(Xhat(2,:), '--', 'linewidth', 2)
% plot(Xfilt(2,:), '--', 'linewidth', 2)