1;


#antes crear su propio vector de tiempo (t) basándose en una frecuencia de muestreo.
#no necesitamos generar una señal sinc entera desde cero en cada iteración;
#necesitamos evaluar la función sinc en un valor específico (el argumento calculado).

function y = sinc(valor_entrada, fs = 0.5)
  % Calculamos el argumento interno de la función
  x = 2 * pi * fs * valor_entrada;

  % Preasignamos con unos (maneja automáticamente el caso donde x == 0)
  y = ones(size(x));

  % Indices donde x NO es 0
  indices = find(x != 0);

  % Calculamos la atenuación sinc solo donde no hay división por cero
  y(indices) = sin(x(indices)) ./ x(indices);
endfunction

% 1. Parámetros de Muestreo
fs = 10;            % Frecuencia original (10 Hz)
T = 1/fs;           % Período original
L = 4;              % Factor de sobremuestreo
fi = fs * L;        % Nueva frecuencia (40 Hz)
Ti = 1/fi;          % Nuevo período

% 2. Generar señal original (senoidal de prueba de 2 Hz, siempre menor a 5)
f_sig = 2;
t_n = 0 : T : 1;
x_n = sin(2 * pi * f_sig * t_n);
N = length(x_n);

% 3. Configurar la señal interpolada
t_m = 0 : Ti : 1;
M = length(t_m);
x_i = zeros(1, M);

% 4. Interpolación usando tu función 'mi_sinc'
for m = 1:M
    suma = 0;

    for n = 1:N
        tiempo_m = (m - 1) * Ti;
        tiempo_n = (n - 1) * T;

        % Calculamos el argumento para la función I
        arg = (tiempo_m - tiempo_n) / T;

        I_val = sinc(arg);

        suma = suma + (x_n(n) * I_val);
    end

    x_i(m) = suma;
end

% 5. Gráficas
figure;
hold on;
stem(t_m, x_i, 'b', 'filled');
plot(t_m, x_i, 'b-', 'Color', [0 0 1 0.2]);
stem(t_n, x_n, 'r', 'LineWidth', 2, 'MarkerSize', 8);
title('Sobremuestreo de 10 Hz a 40 Hz usando mi\_sinc');
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Interpolada (40 Hz)', 'Envolvente', 'Original (10 Hz)');
grid on;
hold off;
