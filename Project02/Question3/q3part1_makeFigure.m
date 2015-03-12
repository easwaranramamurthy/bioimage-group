xAxis = linspace(-1000, 1000);
airyDisks = [];

airyDisks = [airyDisks;q3part1_getAiryDiskFunction(480, 0.5, xAxis)];
airyDisks = [airyDisks;q3part1_getAiryDiskFunction(520, 0.5, xAxis)];
airyDisks = [airyDisks;q3part1_getAiryDiskFunction(680, 0.5, xAxis)];
airyDisks = [airyDisks;q3part1_getAiryDiskFunction(520, 1.0, xAxis)];
airyDisks = [airyDisks;q3part1_getAiryDiskFunction(520, 1.4, xAxis)];
airyDisks = [airyDisks;q3part1_getAiryDiskFunction(680, 1.5, xAxis)];

plot(xAxis, airyDisks(1,:), xAxis, airyDisks(2,:), xAxis, airyDisks(3,:), xAxis, airyDisks(4,:), xAxis, airyDisks(5,:), xAxis, airyDisks(6,:));
ylim([0 1.05]);
title('Point Spread Function (Airy Disk) for different lambda and NA');
xlabel('Radial Distance from optical axis (nm)');
ylabel('Intensity');
legend('lambda = 480, NA = 0.5','lambda = 520, NA = 0.5', 'lambda = 680, NA = 0.5','lambda = 520, NA = 1.0','lambda = 520, NA = 1.4','lambda = 680, NA = 1.5');