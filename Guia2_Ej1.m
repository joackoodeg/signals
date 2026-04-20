x = [1 2 3 4];
h = [1 0 1];

N = length(x);
M = length(h);

y_manual = conv_lineal(x, h);
y_conv = conv(x, h);

% Convolución usando filter
% Agregamos M-1 ceros al final de x
x_padded = [x, zeros(1, M - 1)];
A = 1;
B = h;
y_filter = filter(B, A, x_padded);

figure;

% 1: Manual
subplot(3,1,1);
stem(y_manual, 'filled', 'b');
title('Convolución Manual');
grid on;

% 2: Función conv()
subplot(3,1,2);
stem(y_conv, 'filled', 'r');
title('Convolución Nativa (conv)');
grid on;

% 3: Función filter()
subplot(3,1,3);
stem(y_filter, 'filled', 'g');
title('Convolución con filter()');
grid on;
