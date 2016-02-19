clear all
close all

j = sqrt(-1);

load '2User2AntennaBS'

tr1 = 5000:10160;
tr2 = 15140:20330;

td = 17;

h11x = y1(tr1)./x1(tr1-td);
h21x = y2(tr1)./x1(tr1-td);

h11 = mean(h11x(~isinf(h11x)));
h21 = mean(h21x(~isinf(h21x)));

h12x = y1(tr2)./x2(tr2-td);
h22x = y2(tr2)./x2(tr2-td);

h12 = mean(h12x(~isinf(h12x)));
h22 = mean(h22x(~isinf(h22x)));

H = [h11 h12;
     h21 h22];

w = inv(H')*[1; 0];

y = transpose([y1 y2]);

xhat = w'*y;
data = schmitt(real(xhat), 1);
(1:length(data))-td;

figure(1)
subplot(211);
plot(real(xhat))
hold on
plot(data.*2-1)
plot((1:length(x1))+td+3,x1)
% legend('Real x1', 'Real x2', 'Imag 1', 'Imag 2')

subplot(212);
w = inv(H')*[0; 1];
y = transpose([y1 y2]);
xhat = w'*y;
data = schmitt(real(xhat), 1);
(1:length(data))-td;
plot(real(xhat))
hold on
plot(data.*2-1)
plot((1:length(x2))+td+3,x2)