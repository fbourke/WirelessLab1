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

txlen = 200;
X2 = round(rand(4, txlen));

Y2 = MIMOChannel4x4(X2);

for i = 1:N
    Xhat(i,:) = W(:,i)'*Y2;
end

figure
plot(real(X2(1,:)))
hold on
plot(real(Xhat(1,:)), '--')