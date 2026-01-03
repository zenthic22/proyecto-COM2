function transmision = codificar_huffman(msg, codeword)

    if isstring(msg)
        msg = char(msg);
    end

    transmision = [];

    for k = 1:length(msg)
        s = msg(k);

        idx = find(codeword.Simbolo == s, 1);
        if isempty(idx)
            error("Simbolo '%s' no existe en el codeword", s);
        end

        codeStr = codeword.Codigo(idx);
        codeChar = char(codeStr);
        codeBits = codeChar - '0';

        transmision = [transmision, codeBits];
    end
end