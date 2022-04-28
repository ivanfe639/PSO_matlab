% Funcin para verificar si los agentes se encuentran en el espacio de 
% busqueda vlido y ajustar segn sea necesario
%
%   X: vector de Nd posiciones
%   boundaries: Matriz de limites de busqueda
%   ResMode: Modo de restitucion 
%%
function [X,RngOK] = Chk_Feas(X,boundaries,ResMode)
RngOK = 1;
for i = 1:size(boundaries,1),
    blo = boundaries(i,1);
    bup = boundaries(i,2);
    if  X(i) < blo || X(i)> bup,
        RngOK = 0; % At least one value is out of bounds
        % Begin data adjustment according to options
        switch ResMode
            case 1                
                X(i) = blo + rand*(bup - blo);
            case 2
                if X(i) <= blo
                    X(i) = blo;
                else 
                    X(i) = bup;
                end
            otherwise
                X(i) = X(i);
        end
        % End data adjustment
    end
end