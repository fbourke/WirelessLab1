clear all

j = sqrt(-1);

load '2User2AntennaBS'

tr1 = 5000:10160;
tr2 = 15140:20330;

ns = tr1(end)+1:tr2(1)-1;

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

h1 = H(:,1);
h2 = H(:,2);
y = transpose([y1 y2]);

sig = [std(abs(y1(ns))) 0;
        0 std(abs(y2(ns)))]

A = h1*h1' + h2*h2' + sig;

w1 = inv(A')*h1;

x1hat = w1'*y;
x1hatf = schmitt(real(x1hat), 1);

dlen = length(x1hat) - length(x1);

x1cmp = [zeros(1, td) transpose(x1) zeros(1, dlen)];

E1 = x1cmp(1:end-td) - x1hat;

wind = [3e4, 3.2e4];

figure

% plotting
subplot(211)
plot((1:length(x1))+td,x1, 'linewidth', 2)
hold on
plot(real(x1hat))
plot(x1hatf.*2-1, '--', 'linewidth', 2)
legend('Tx Data', 'Rx MMSE', 'Rx Filtered')
ylabel('Amplitude')
xlim(wind)

w2 = inv(A')*h2;

x2hat = w2'*y;
x2hatf = schmitt(real(x2hat), 1);

dlen = length(x2hat) - length(x2);

x2cmp = [zeros(1, td) transpose(x2) zeros(1, dlen)];

E2 = x2cmp(1:end-td) - x2hat;

subplot(212)
plot((1:length(x2))+td,x2, 'linewidth', 2)
hold on
plot(real(x2hat))
plot(x2hatf.*2-1, '--', 'linewidth', 2)
legend('Tx Data', 'Rx MMSE', 'Rx Filtered')
xlabel('Sample Number')
ylabel('Amplitude')
xlim(wind)

% title code
set(gcf,'NextPlot','add');
axes;
h = title('Signal Isolation With MMSE Estimation');
set(gca,'Visible','off');
set(h,'Visible','on');