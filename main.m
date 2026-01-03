disp("========================================");
disp("  PROYECTO FINAL - GRUPO 5 ");
disp("========================================");

% Se pide el mensaje
msg = input("Ingrese el mensaje de texto: ", "s");

% Variables para guardar resultados
simbolos = [];
conteos  = [];
p        = [];
H        = [];
codeword = [];
arbol     = [];
transmision = [];
recepcion = [];
msgrecibido = "";

while true
    disp(" ");
    opcion = menu("Seleccione una opcion:", ...
        "1) Calcular distribucion de probabilidad (Inciso 1) y entropia (Inciso 2)", ...
        "2) Construir Huffman (Inciso 3) y Calculo de longitud promedio (Inciso 4)", ...
        "3) Transmitir bits por canal BSC (Inciso 5)", ...
        "4) Reconstruir el mensaje (Inciso 6)", ...
        "5) Entropia del mensaje recibido (Inciso 7)", ...
        "6) Salir");

    if opcion == 1
        % Inciso 1
        [simbolos, conteos, p] = frecuencia(msg);

        disp(" ");
        disp("=== Inciso 1: Distribucion de probabilidad ===");
        T = table(simbolos(:), conteos(:), p(:), ...
            'VariableNames', {'Simbolo','Frecuencia','Probabilidad'});
        T = sortrows(T, 'Probabilidad','descend');
        disp(T);
        fprintf("Suma de probabilidades: %.4f\n", sum(p));

        % Inciso 2
        H = entropia(msg);
        disp(" ");
        disp("=== Inciso 2: Entropia ===");
        fprintf("H = %.6f bits/simbolo\n", H);

    elseif opcion == 2
        % Para Huffman necesitas simbolos y p
        if isempty(p)
            disp("Primero ejecute la opcion 1 para obtener simbolos y probabilidades.");
            continue;
        end

        % Inciso 3: construir Huffman
        [codeword, arbol] = constructor_huffman(simbolos, p);

        % Emparejar probabilidad con cada simbolo del codebook
        p_match = zeros(height(codeword), 1);
        for i = 1:height(codeword)
            idx = find(simbolos == codeword.Simbolo(i), 1);
            p_match(i) = p(idx);
        end

        % Longitud de cada codigo
        longitudes = strlength(codeword.Codigo);

        % Tabla completa (Inciso 3 e inciso 4)
        tablaHuffman = table( ...
            codeword.Simbolo, ...
            p_match, ...
            codeword.Codigo, ...
            longitudes, ...
            'VariableNames', {'Simbolo','Probabilidad','Codigo','Longitud'} );

        tablaHuffman = sortrows(tablaHuffman, 'Probabilidad', 'descend');

        disp(" ");
        disp("=== Inciso 3 y 4: Huffman (Codigo y Longitud) ===");
        disp(tablaHuffman);

        % Inciso 4: Longitud promedio
        L = sum(tablaHuffman.Probabilidad .* double(tablaHuffman.Longitud));

        disp(" ");
        disp("=== Inciso 4: Longitud promedio del codigo de Huffman ===");
        fprintf("L = %.6f bits/simbolo\n", L);

    elseif opcion == 3
        % Inciso 5: transmitir por canal BSC
        if isempty(codeword)
            disp("Primero ejecute la opcion 2 para construir Huffman.");
            continue;
        end

        pe = input("Ingrese probabilidad de error del canal: ");

        transmision = codificar_huffman(msg, codeword);
        recepcion   = canal_bsc(transmision, pe);

        transmision = transmision(:).';
        recepcion   = recepcion(:).';

        disp(" ");
        disp("=== Inciso 5: Canal Binario Simetrico ===");
        fprintf("Bits transmitidos : %d\n", length(transmision));
        fprintf("pe ingresado      : %.6f\n", pe);

        nshow = min(80, length(transmision));

        disp(" ");
        disp("Bits transmitidos:");
        disp(transmision(1:nshow));

        disp("Bits recibidos:");
        disp(recepcion(1:nshow));

    elseif opcion == 4
        %Inciso 6: reconstruccion del mensaje
        if isempty(transmision) || isempty(recepcion)
            disp("Primero ejecute el canal (Inciso 5).");
            continue;
        end

        msgRec = decodificar_huffman(msg, transmision, recepcion, codeword);
        msgrecibido = string(msgRec);

        disp(" ");
        disp("=== Inciso 6: Mensaje reconstruido ===");
        disp("Mensaje original:");
        disp(msg);
        disp("Mensaje recibido:");
        disp(string(msgRec));

    elseif opcion == 5
        % Inciso 7: entropia del mensaje recibido
        if strlength(msgrecibido) == 0
            disp("Primero ejecute el inciso 6 para reconstruir el mensaje.");
            continue;
        end

        H_y = entropia(msgrecibido);

        disp(" ");
        disp("=== Inciso 7: Entropia del mensaje recibido ===");
        disp("Mensaje recibido:");
        disp(msgrecibido);
        fprintf("H recibido = %.6f bits/simbolo\n", H_y);

        if ~isempty(H)
            disp("Comparacion:");
            fprintf("H original = %.6f bits/simbolo\n", H);
            fprintf("H recibido = %.6f bits/simbolo\n", H_y);
        end        

    elseif opcion == 6
        disp("Saliendo...");
        break;

    else
        disp("Opcion invalida. Saliendo...");
        break;
    end
end
