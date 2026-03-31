close all;
graphics_toolkit("gnuplot"); # EVITA QUE ME CRASHEE

N = 10000; # Nro de muestras temporales
M = 500;   # Nro de realizaciones (señales independientes)

# Generar la señal aleatoria gaussiana (media = 0, varianza = 1)
# randn genera directamente valores con distribucion normal estandar
X = randn(M, N); # Matriz MxN

# Calculamos la media y la varianza del ensamble para cada instante temporal 'n'
media_ensamble = mean(X, 1); # Media a lo largo de las filas (M realizaciones)
# mean(Matriz,Dimension) Dimension = 1 -> Filas

varianza_ensamble = var(X, 0, 1); # Varianza a lo largo de las filas
# var(Matriz,Factor de Normalizacion, Dimension)

figure(1);
subplot(2,1,1);
title('Media del ensamble en función del tiempo');
plot(media_ensamble);
ylim([-0.5 0.5]);

subplot(2,1,2);
title('Varianza del ensamble en función del tiempo');
plot(varianza_ensamble);
ylim([0.5 1.5]);

# ERGODICIDAD
# Tomamos una realización cualquiera (por ejemplo, la primera fila)
realizacion_1 = X(1, :);
media_temporal = mean(realizacion_1);
varianza_temporal = var(realizacion_1);

fprintf('Media temporal (1 realización): %f (Teórico: 0)\n', media_temporal);
fprintf('Varianza temporal (1 realización): %f (Teórico: 1)\n', varianza_temporal);

# CONVERGENCIA AL AUMENTAR MUESTRAS (N)
muestras_vector = 10:10:N;
media_convergencia_N = zeros(1, length(muestras_vector));
varianza_convergencia_N = zeros(1, length(muestras_vector));

for i = 1:length(muestras_vector)
    # Calculamos aumentando iterativamente la cantidad de muestras
    datos_parciales = realizacion_1(1:muestras_vector(i));
    media_convergencia_N(i) = mean(datos_parciales);
    varianza_convergencia_N(i) = var(datos_parciales);
end

figure(2);
subplot(2,1,1);
plot(muestras_vector, media_convergencia_N);
title('Convergencia de la media temporal al aumentar N muestras');
ylabel('Media (Tiende a 0)');
grid on;

subplot(2,1,2);
plot(muestras_vector, varianza_convergencia_N);
title('Convergencia de la varianza temporal al aumentar N muestras');
xlabel('Número de muestras (N)');
ylabel('Varianza (Tiende a 1)');
grid on;

# CONVERGENCIA AL AUMENTAR REALIZACIONES (M)
instante_n = X(:, 100); # Tomamos la columna 100 (un instante cualquiera)
realizaciones_vector = 10:10:M;
media_convergencia_M = zeros(1, length(realizaciones_vector));
varianza_convergencia_M = zeros(1, length(realizaciones_vector));

for i = 1:length(realizaciones_vector)
    # Calculamos aumentando iterativamente la cantidad de realizaciones
    datos_parciales_M = instante_n(1:realizaciones_vector(i));
    media_convergencia_M(i) = mean(datos_parciales_M);
    varianza_convergencia_M(i) = var(datos_parciales_M, 0);
end

figure(3);
subplot(2,1,1);
plot(realizaciones_vector, media_convergencia_M);
title('Convergencia de la media del ensamble al aumentar M realizaciones');
ylabel('Media (Tiende a 0)');
grid on;

subplot(2,1,2);
plot(realizaciones_vector, varianza_convergencia_M);
title('Convergencia de la varianza del ensamble al aumentar M realizaciones');
xlabel('Número de realizaciones (M)');
ylabel('Varianza (Tiende a 1)');
grid on;
