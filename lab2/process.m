clear all
close all

j = sqrt(-1);

load '2User2AntennaBS'

tr1 = 5000:10160;
tr2 = 15140:20330;

td = 20;

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
xhatf = schmitt(real(xhat), 1);
(1:length(xhatf))-td;

figure
set(gcf,'NextPlot','add');
axes;
h = title('Signal Isolation With Zero Forcing');
set(gca,'Visible','off');
set(h,'Visible','on');

plot((1:length(x1))+td,x1)
hold on
plot(real(xhat))
plot(xhatf.*2-1)
legend('Tx Data', 'Rx Zero-Forced', 'Rx Filtered')

w = inv(H')*[0; 1];
y = transpose([y1 y2]);
xhat = w'*y;
xhatf = schmitt(real(xhat), 1);
subplot(212)
plot((1:length(x2))+td,x2)
hold on
plot(real(xhat))
plot(xhatf.*2-1)
legend('Tx Data', 'Rx Zero-Forced', 'Rx Filtered')