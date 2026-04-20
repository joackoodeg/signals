x = [1, 2, 3, 4, 5, 6 ,7, 8];
h = [1, 0, -1, 1, 1, 0, -1, 0];

N = length(x);

y_circular_manual = conv_cir(x, h);

figure;
n_axis = 0 : N-1; % Eje de tiempo discreto

stem(n_axis, y_circular_manual, 'filled', 'b', 'LineWidth', 1.5);
title('Convolución Circular Manual (Ciclos FOR)');
xlabel('n'); ylabel('y[n]');
grid on;

