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

H

% figure
% clf
% plot(abs(Y(1,:,4)))
% hold on
% plot(abs(Y(:,:,2)))
% plot(abs(Y(:,:,3)))
% plot(abs(Y(:,:,4)))