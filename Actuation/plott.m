h=figure;
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,1),'k--','LineWidth', 2); hold on
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,2),'b', 'LineWidth', 2.5);
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,3), 'r','LineWidth', 2.5);
set(gca, 'FontSize', 24);
%title(['Strategy n. ' num2str(politik)]);
grid on
ylabel('Voltage (V)');
xlabel('Time (s)');
ylim([-0.7 0.7]);
%saveas(h,['../P_' file_name '.eps'])

h1=figure;
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,1),'k--', 'LineWidth', 2); hold on
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,4),'b', 'LineWidth', 2.5);
plot(simNoiseJitterKalman.time, simNoiseJitterKalman.signals.values(:,5),'r', 'LineWidth', 2.5);
set(gca, 'FontSize', 24);
%title(['Strategy n. ' num2str(politik)]);
grid on;
ylabel('Voltage (V)');
xlabel('Time (s)');
ylim([-0.7 0.7]);
%ylim([40 47]);
