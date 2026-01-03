function L = long_promedio(codeword, simbolos, p)


    simbolos = simbolos(:);
    p = p(:);

    %Longitudes por fila del codeword
    longitudes = strlength(codeword.Codigo);

    %Emparejar: para cada simbolo del codeword, buscar su p correspondiente
    p_match = zeros(height(codeword), 1);

    for i = 1:height(codeword)
        s = codeword.Simbolo(i);
        idx = find(simbolos == s, 1);
        if isempty(idx)
            error("Simbolo del codeword no encontrado en simbolos.");
        end
        p_match(i) = p(idx);
    end

    L = sum(p_match .* double(longitudes));
end
