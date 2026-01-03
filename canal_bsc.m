function recepcion = canal_bsc(transmision, pe)

    if pe < 0 || pe > 1
        error("pe debe de estar entre 0 y 1.");
    end

    transmision = transmision(:);

    errores = rand(size(transmision)) < pe;

    recepcion = xor(transmision, errores);
    recepcion = double(recepcion);

end
