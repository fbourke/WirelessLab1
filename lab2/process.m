clear all
close all

j = sqrt(-1);

load '2User2AntennaBS'

tr1 = 5000:10160;
tr2 = 15140:20330;

td = 17;

h11x = y1(tr1)./x1(tr1-td);
h21x = y2(tr1)./x2(tr1-td);

h11 = mean(h11x(~isinf(h11x)));
h21 = mean(h21x(~isinf(h21x)));

figure(1)
hold on
plot(real(h11x))
plot(imag(h11x))