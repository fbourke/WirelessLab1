clear all

load 'rxdata/processed'

figure(1)
colormap 'parula'
clf
plot(real(seg))
hold on
grid on
plot(real(v), 'linewidth', 2)

xlim([.47e4, .6e4])

plot(vfilt*vmag-vmag/2, 'linewidth', 4)
legend('Original Signal', 'After Costas Loop', 'After Schmitt Trigger')
title('Costas Loop Demodulation')
xlabel('Sample')
ylabel('Amplitude')