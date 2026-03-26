1;

function [y, t] = generar_senoidal(fs, fm, phi, t_inicial, t_final)
    t = t_inicial : 1/fm : t_final;

    y = sin(2 * pi * fs * t + phi);
end

function y_nuevo = operacion_dominio_senoidal(t, fs, phi, alpha)
    % 1. Definimos la operación de dominio según tu apunte: τ^{-1}(t) = α * t
    tau_inv = alpha * t;

    % 2. Evaluamos la función original (x_viejo) en el nuevo dominio temporal
    y_nuevo = sin(2 * pi * fs * tau_inv + phi);
endfunction

function y_cuantizada = cuantizar(y_senoidal, N)
  % Paso 1: Hacemos la señal toda positiva restando el mínimo
  minimo_valor = min(y_senoidal);
  y_positiva = y_senoidal - minimo_valor;

  % Paso 2: Calculamos la magnitud del cuanto (H) [cite: 31]
  % Como la señal ahora va de 0 al nuevo máximo, dividimos el rango en N-1 escalones
  H = max(y_positiva) / (N - 1);

  % Paso 3: Aplicamos la ecuación (1) del libro [cite: 27]
  y_cuant_pos = zeros(1, length(y_positiva)); % Inicializamos en 0 (cubre la condición x < 0) [cite: 28]

  % Condición intermedia: si 0 <= x < (N-1)H [cite: 29]
  idx_mid = find(y_positiva >= 0 & y_positiva < (N - 1) * H);
  y_cuant_pos(idx_mid) = H * floor(y_positiva(idx_mid) / H); % Usamos floor() como el equivalente a int()

  % Condición superior: si x >= (N-1)H [cite: 29]
  idx_top = find(y_positiva >= (N - 1) * H);
  y_cuant_pos(idx_top) = (N - 1) * H;

  % Paso 4: Sumamos el mínimo para volver al rango de valores original
  y_cuantizada = y_cuant_pos + minimo_valor;
endfunction

fm = 100;           % Frecuencia de muestreo en Hz
t_inicial = 0;      % Tiempo inicial en segundos
t_final = 1;        % Tiempo final en segundos

% Parámetros de la señal (2*fs <= fm, es decir fs <= 50hz)
fs = 5;             % Frecuencia de la señal en hz
phi = pi/4;         % Fase en radianes

% Generación de las señales llamando a las funciones
[y_senoidal, t] = generar_senoidal(fs, fm, phi, t_inicial, t_final);


% ==========================================
% --- 1. Inversion y Expansion (extra)
% ==========================================

% 1. Inversión (Reversión): alpha = -1
alpha_inv = -1;
y_invertida = operacion_dominio_senoidal(t, fs, phi, alpha_inv);

% 2. Expansión: 0 < alpha < 1
alpha_exp = 0.5;
y_expandida = operacion_dominio_senoidal(t, fs, phi, alpha_exp);


% 3. Compresion: alpha > 1
alpha_comp = 1.5;
y_comprimida = operacion_dominio_senoidal(t, fs, phi, alpha_comp);


% --- Ploteo para comparar ---
figure;

% Gráfico Original
subplot(4, 1, 1);
stem(t, y_senoidal, 'b', 'filled');
title('Señal Original (\alpha = 1)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfico Invertido
subplot(4, 1, 2);
stem(t, y_invertida, 'r', 'filled');
title(['Señal Invertida (\alpha = ', num2str(alpha_inv), ')']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfico Expansion
subplot(4, 1, 3);
stem(t, y_expandida, 'm', 'filled');
title(['Señal Expandida (\alpha = ', num2str(alpha_exp), ')']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfico Compresion
subplot(4, 1, 4);
stem(t, y_comprimida, 'c', 'filled');
title(['Señal Comprimida (\alpha = ', num2str(alpha_comp), ')']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% ==========================================
% --- 2. Rectificación
% ==========================================

% Aplicamos el valor absoluto para rectificar la señal completa
y_rectificada = abs(y_senoidal);

% 1. Hacemos una copia exacta de la señal original
y_media_onda = y_senoidal;

% 2. Buscamos dónde la señal original es menor a cero y forzamos un cero
y_media_onda(y_senoidal < 0) = 0;

% --- Ploteo para comparar Original vs Rectificada ---
figure;

% Gráfico original
subplot(3, 1, 1);
stem(t, y_senoidal, 'b', 'filled');
title('Señal Senoidal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

% Gráfico rectificado
subplot(3, 1, 2);
stem(t, y_rectificada, 'g', 'filled');
title('Señal Rectificada (Onda Completa)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1.5, 1.5]); % Mantenemos el límite inferior en -1.5 para evidenciar que ya no hay valores negativos
grid on;

% Gráfico rectificado media onda
subplot(3, 1, 3);
stem(t, y_media_onda, 'g', 'filled');
title('Señal Rectificada (Media Onda)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1.5, 1.5]); % Mantenemos los límites para ver bien el piso en cero
grid on;


% ==========================================
% --- 3. Cuantización en 8 niveles ---
% ==========================================

N = 8; % Número de niveles de la cuantización

y_cuantizada = cuantizar(y_senoidal, N);

% --- Ploteo para comparar Original vs Cuantizada ---
figure;
hold on; % hold on permite superponer dos gráficos en el mismo cuadro
stem(t, y_senoidal, 'b', 'filled'); % Señal original en azul

% Usamos 'stairs' para dibujar los escalones típicos de una señal cuantizada
stairs(t, y_cuantizada, 'r', 'linewidth', 2);

title('Cuantización de la Señal Senoidal en 8 niveles');
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Señal Original', 'Señal Cuantizada');
grid on;
hold off;
