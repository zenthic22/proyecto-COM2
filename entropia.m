function H = entropia(msg)

    [~, ~, p] = frecuencia(msg);

    p = p(p > 0);

    H = -sum(p .* log2(p));

end