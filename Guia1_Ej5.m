fs = 4000;             % Frecuencia de la señal en hz
phi = pi/4;         % Fase en radianes
fm = 129;

[y, t] = generar_senoidal(fs, fm, phi, 0, 2);
figure;
title('Señal Original (\alpha = 1)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
plot(t,y);
grid on;

