N = 40;     % Nro de muestras
a = 0.8;    % a debe ser |a| < 1
n = 0:N-1;  % Vector de tiempo discreto

% Generar las respuestas al impulso
hA = sin(8*n);
hB = a.^n;

% Generar la señal de entrada x[n] = d[n] - a*d[n-1]
% d[n] es 1 en el primer índice, d[n-1] es 1 en el segundo índice
x = zeros(1, N);
x(1) = 1;
x(2) = -a;

% Conexion original (x -> hA -> hB)
w_orig = conv_lineal(x, hA);
y_orig = conv_lineal(w_orig, hB);

% Conexion invertida (x -> hB -> hA)
w_inv = conv_lineal(x, hB);
y_inv = conv_lineal(w_inv, hA);

% Comprobamos si las salidas son iguales
diferencia = max(abs(y_orig - y_inv));
disp(['Diferencia max entre ambas conexiones: ', num2str(diferencia)]);

% Graficamos
figure;
subplot(2,1,1);
stem(y_orig, 'filled', 'b');
title('Salida y[n] - Conexión Original (hA -> hB)');

subplot(2,1,2);
stem(y_inv, 'filled', 'r');
title('Salida y[n] - Conexión Invertida (hB -> hA)');
