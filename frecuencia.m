function [simbolos, conteos, p] = frecuencia(msg)

    if isstring(msg)
        msg = char(msg);
    end
    
    % Obtener simbolos unicos
    simbolos = unique(msg);

    % Contar ocurrencias
    conteos = zeros(size(simbolos));
    for k = 1:length(simbolos)
        conteos(k) = sum(msg == simbolos(k));
    end

    % Probabilidades
    N = length(msg);
    p = conteos / N;

end