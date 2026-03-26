#frecuencia 5 Hz y
#duraci´on 1 seg. Para ello utilice las siguientes frecuencias de muestreo: 100,
#25, 10, 4, 1 y 0,5 Hz. Analice el resultado

fs = 5;             % Frecuencia de la señal en hz
phi = pi/4;         % Fase en radianes
fm = [100,25, 10, 4, 1, 0.5];

% 1. Creamos una única ventana ANTES de entrar al bucle
figure('Name', 'Análisis de Frecuencias de Muestreo', 'NumberTitle', 'off');

% 2. Cambiamos el bucle para iterar por el índice del arreglo
for i = 1:length(fm)
  muestreo = fm(i); % Obtenemos la frecuencia actual

  [y, t] = generar_senoidal(fs, muestreo, phi, 0, 1);

  % 3. Dividimos la ventana en 2 filas y 3 columnas, seleccionando la posición 'i'
  subplot(2, 3, i);

  stem(t, y, 'filled');

  % Títulos y etiquetas adaptadas para que no ocupen tanto espacio
  title(['f_m = ', num2str(muestreo), ' Hz']);
  xlabel('t (s)');
  ylabel('Amp');
  grid on;
end

