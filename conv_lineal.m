function y = conv_lineal(x, h)
    Nx = length(x);
    Nh = length(h);

    % Longitud de la salida
    Ny = Nx + Nh - 1;

    % Inicializar salida
    y = zeros(1, Ny);

    % Convolución
    for n = 1:Ny
        for k = 1:Nx
            lim = n-k+1;
            if (lim > 0 && lim <= Nh)
                y(n) = y(n) + x(k) * h(n-k+1);
            end
        end
    end
end
