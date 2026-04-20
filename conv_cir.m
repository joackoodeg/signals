function y = conv_circular(x, h)
    Nx = length(x);
    Nh = length(h);

    if (Nx ~= Nh)
        error('Para la convolución circular, ambas señales deben tener la misma longitud N.');
    end

    N = Nx;
    y = zeros(1, N);

    for k = 1:N
        for l = 1:N
            indice_x = mod(N + k - l, N) + 1;
            y(k) = y(k) + h(l) * x(indice_x);
        end
    end
end
