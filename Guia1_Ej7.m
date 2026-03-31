graphics_toolkit("gnuplot");

% Parámetros de la simulación
N = 10000; % Número de muestras temporales
M = 500;   % Número de realizaciones (señales independientes)

% Generación de la señal aleatoria gaussiana (media = 0, varianza = 1)
% randn genera directamente valores con distribución normal estándar
X = randn(M, N);

%% --- A. VERIFICACIÓN DE ESTACIONARIEDAD ---
% Calculamos la media y la varianza del ensamble para cada instante temporal 'n'
media_ensamble = mean(X, 1); % Media a lo largo de las filas (M realizaciones)
varianza_ensamble = var(X, 0, 1); % Varianza a lo largo de las filas

% Si graficamos, los valores deberían oscilar muy cerca de 0 (media) y 1 (varianza)
figure(1);
subplot(2,1,1);
plot(media_ensamble);
title('Media del ensamble en función del tiempo (Debe tender a 0)');
ylim([-0.5 0.5]);

subplot(2,1,2);
plot(varianza_ensamble);
title('Varianza del ensamble en función del tiempo (Debe tender a 1)');
ylim([0.5 1.5]);

%% --- B. VERIFICACIÓN DE ERGODICIDAD ---
% Para que sea ergódico, la media temporal de UNA realización debe igualar a la del ensamble.
% Tomamos una realización cualquiera (por ejemplo, la primera fila)
realizacion_1 = X(1, :);
media_temporal = mean(realizacion_1);
varianza_temporal = var(realizacion_1);

fprintf('Media temporal (1 realización): %f (Teórico: 0)\n', media_temporal);
fprintf('Varianza temporal (1 realización): %f (Teórico: 1)\n', varianza_temporal);

%% --- C. CONVERGENCIA DE LOS ESTIMADORES ---
% El apunte requiere observar la tendencia al incrementar muestras/realizaciones
muestras_vector = 10:10:N;
media_convergencia = zeros(1, length(muestras_vector));

for i = 1:length(muestras_vector)
    % Calculamos la media temporal aumentando iterativamente la cantidad de muestras
    media_convergencia(i) = mean(realizacion_1(1:muestras_vector(i)));
end

figure(2);
plot(muestras_vector, media_convergencia);
title('Convergencia de la media temporal al aumentar N muestras');
xlabel('Número de muestras (N)');
ylabel('Valor estimado de la media');
grid on;
