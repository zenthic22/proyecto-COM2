function [codeword, arbol] = constructor_huffman(simbolos, p)


    %Validaciones simples
    if length(simbolos) ~= length(p)
        error("simbolos y p deben tener la misma longitud.");
    end

    %Asegurar columna
    simbolos = simbolos(:);
    p = p(:);

    %Crear lista inicial de nodos
    nodes = cell(length(simbolos), 1);
    for i = 1:length(simbolos)
        node.prob   = p(i);
        node.sym    = simbolos(i);
        node.left   = [];
        node.right  = [];
        node.isLeaf = true;
        nodes{i} = node;
    end

    %Construcción del árbol Huffman
    while numel(nodes) > 1
        %Ordenar nodos por probabilidad ascendente
        probs = cellfun(@(n) n.prob, nodes);
        [~, idx] = sort(probs, "ascend");
        nodes = nodes(idx);

        %Tomar los dos nodos con menor probabilidad
        a = nodes{1};
        b = nodes{2};

        %Crear nuevo nodo padre
        parent.prob   = a.prob + b.prob;
        parent.sym    = [];      % no aplica
        parent.left   = a;       % asignamos 0 a la izquierda
        parent.right  = b;       % asignamos 1 a la derecha
        parent.isLeaf = false;

        %Reemplazar los dos primeros por el padre
        nodes = nodes(3:end);
        nodes{end+1} = parent;
    end

    %Raíz final
    arbol = nodes{1};

    %Obtener códigos recorriendo el árbol
    [symsOut, codesOut] = arbol_huffman(arbol);

    %Crear el codeword como tabla
    codeword = table(symsOut(:), codesOut(:), 'VariableNames', ...
        {'Simbolo','Codigo'});

    %Ordenar la tabla por símbolo
    [~, ord] = sort(codeword.Simbolo);
    codeword = codeword(ord, :);
end
