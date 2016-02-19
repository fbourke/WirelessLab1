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
     h21 h22]

w = inv(H')*[1; 0];

xhat = y1*w';

figure(1)
clf
plot(real(xhat))
hold on
plot(imag(xhat))

legend('Real 1', 'Real 2', 'Imag 1', 'Imag 2')