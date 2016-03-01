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
        H(i,j) = mean(h(~isinf(h)));
    end
end

Hdag = inv(H');
I = eye(N,N);

for i = 1:N
    W(:,i) = Hdag*I(:,i);
end

txlen = 10;
pw = 5;
Xgen = round(rand(4, txlen));
for i = 1:N
    X2(i,:) = conv(upsample(Xgen(i,:), pw), ones(1, pw));
end

Y2 = MIMOChannel4x4(X2);

for j = 1:N
    Xhat(j,:) = W(:,j)'*Y2;
    Xnorm(j,:) = real(Xhat(j,:))/max(real(Xhat(j,:)));
    x = Xnorm(j,:);
    Xfilt(j,:) = schmitt(x, .55, .45);
end

figure
plot(real(X2(1,:)), 'linewidth', 2)
hold on
plot(Xnorm(1,:), '--', 'linewidth', 2)
plot(Xfilt(1,:), '--', 'linewidth', 2)