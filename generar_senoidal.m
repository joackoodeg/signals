function [y, t] = generar_senoidal(fs, fm, phi, t_inicial, t_final)
    t = t_inicial : 1/fm : t_final;

    y = sin(2 * pi * fs * t + phi);
end
