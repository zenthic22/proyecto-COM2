function [simbolos, codigos] = arbol_huffman(node, prefix)

    if nargin < 2
        prefix = "";
    end

    if node.isLeaf
        simbolos = node.sym;
        codigos  = prefix;
        return;
    end

    %Recorrer izquierda (agrega '0')
    [sL, cL] = arbol_huffman(node.left,  prefix + "0");
    %Recorrer derecha (agrega '1')
    [sR, cR] = arbol_huffman(node.right, prefix + "1");

    simbolos = [sL; sR];
    codigos  = [cL; cR];
end
