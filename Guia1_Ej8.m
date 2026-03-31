clear all; close all; clc;
graphics_toolkit("gnuplot");

% --- Parámetros iniciales ---
fs = 1000;          % Frecuencia de muestreo
t = 0:1/fs:1-1/fs;  % Vector de tiempo (1 segundo)
f_seno = 5;         % Frecuencia de la señal conocida (5 Hz)

% 1. Generar señal, ruido y sumarlos [cite: 77]
senal = sin(2*pi*f_seno*t);  % Señal conocida
ruido = randn(1, length(t)); % Ruido gaussiano (media 0, varianza 1)
senal_contaminada = senal + ruido;

% Graficar el resultado [cite: 77]
figure(1);
subplot(3,1,1); plot(t, senal); title('Señal Original (Limpia)');
subplot(3,1,2); plot(t, ruido); title('Ruido Aleatorio');
subplot(3,1,3); plot(t, senal_contaminada); title('Señal + Ruido');
xlabel('Tiempo (s)');

% 2. Calcular potencias y SNR original [cite: 78]
% Usamos el valor medio cuadrático como indica el apunte
P_senal = mean(senal.^2);
P_ruido = mean(ruido.^2);

SNR_lin = P_senal / P_ruido;
SNR_dB = 10 * log10(SNR_lin);

fprintf('--- RESULTADOS INICIALES ---\n');
fprintf('Potencia de la señal: %.4f\n', P_senal);
fprintf('Potencia del ruido: %.4f\n', P_ruido);
fprintf('SNR Original: %.2f dB\n\n', SNR_dB);

% 3. Multiplicar ruido por una constante cualquiera y recalcular SNR [cite: 79]
C = 2; % Constante arbitraria
ruido_amplificado = C * ruido;
P_ruido_amplificado = mean(ruido_amplificado.^2);
SNR_modificada_dB = 10 * log10(P_senal / P_ruido_amplificado);

fprintf('--- RUIDO MULTIPLICADO POR %d ---\n', C);
fprintf('Nueva potencia de ruido: %.4f\n', P_ruido_amplificado);
fprintf('Nueva SNR: %.2f dB\n\n', SNR_modificada_dB);

% 4. Despejar y aplicar 'k' para que SNR = 0 dB
% k = sqrt(P_senal / P_ruido_original)
k = sqrt(P_senal / P_ruido);

ruido_0dB = k * ruido;
P_ruido_0dB = mean(ruido_0dB.^2);
SNR_0dB = 10 * log10(P_senal / P_ruido_0dB);

fprintf('--- FORZANDO SNR A 0 dB ---\n');
fprintf('Valor calculado de la constante k: %.4f\n', k);
fprintf('Potencia del nuevo ruido (debe igualar a P_senal): %.4f\n', P_ruido_0dB);
fprintf('SNR Resultante (debería ser muy cercana a 0): %.2f dB\n', SNR_0dB);
