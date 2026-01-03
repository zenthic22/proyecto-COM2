function msgrecibido = decodificar_huffman(msg, transmision, recepcion, codeword)


    if isstring(msg)
        msg = char(msg);
    end

    transmision = transmision(:).';
    recepcion = recepcion(:).';

    pos = 1;
    out = char([]);

    for k = 1:length(msg)
        %buscar codigo del simbolo original
        idx = find(codeword.Simbolo == msg(k), 1);
        codeStr = char(codeword.Codigo(idx));
        L = length(codeStr);

        %si no hay suficientes bits recibidos
        if pos + L - 1 > length(recepcion)
            out(end+1) = '?';
            break;
        end

        %extraer bits
        txBits = transmision(pos:pos+L-1);
        rxBits = recepcion(pos:pos+L-1);

        %comparar
        if isequal(txBits, rxBits)
            out(end+1) = msg(k);
        else
            out(end+1) = '?';
        end

        pos = pos + L;
    end

    msgrecibido = out;
end
