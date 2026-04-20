% Integrador Parte II:
N = 20;
n = 0:N-1;

% Generamos el impulso unitario (1 seguido de 19 ceros)
delta = [1, zeros(1, N-1)];

% Definimos los coeficientes del sistema a partir de la ecuación
B = [1, 0.2];   % Coeficientes de la entrada x
A = [1, -0.6];  % Coeficientes de la salida y

% Calculamos la respuesta al impulso
h = filter(B, A, delta);

% Graficamos
figure;
stem(n, h, 'filled', 'b', 'LineWidth', 1.5);
title('Respuesta al Impulso h[n] del Sistema IIR');
xlabel('n (muestras)');
ylabel('Amplitud');
grid on;

% Integrador Parte III:

% Definimos la señal arbitraria (Pulso rectangular de L=10)
L = 10;
x = ones(1, L);
M = length(h); % h (de 20 muestras) sigue en memoria

% a) Sumatoria de convolución
y_a = conv_lineal(x, h);

% b) Representación matricial
N_total = L + M - 1; % Longitud teórica: 10 + 20 - 1 = 29
H_matriz = zeros(N_total, L); % Matriz de 29 filas x 10 columnas

% Llenamos la matriz columna por columna desplazando 'h' hacia abajo
for col = 1:L
    H_matriz(col : col + M - 1, col) = h';
end

% Multiplicación matricial clásica y transposición para graficar
y_b = (H_matriz * x')';

% c) Convolución circular (con zero-padding)
N_total = L + M - 1; % 10 + 20 - 1 = 29
x_pad = [x, zeros(1, N_total - L)];
h_pad = [h, zeros(1, N_total - M)];
y_c = conv_cir(x_pad, h_pad);

% d) Verificación (Comparamos que los resultados coincidan)
error_ab = max(abs(y_a - y_b));
error_ac = max(abs(y_a - y_c));

disp('--- Resultados de la Verificación ---');
disp(['Error máximo entre Método A y B: ', num2str(error_ab)]);
disp(['Error máximo entre Método A y C: ', num2str(error_ac)]);

% VISUALIZACIÓN
figure;
subplot(3,1,1);
stem(y_a, 'filled', 'b');
title('a) Convolución Lineal (Sumatoria)');
grid on;

subplot(3,1,2);
stem(y_b, 'filled', 'r');
title('b) Representación Matricial');
grid on;

subplot(3,1,3);
stem(y_c, 'filled', 'g');
title('c) Convolución Circular (con Zero-Padding)');
grid on;
