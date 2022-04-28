% La funcin Seeder devuelve un vector con elementos que pertenecen
% a la regin factible definida en el problema.
%
% El argumento de entrada bnd corresponde a los lmites para cada
% dimensin del dominio de bsqueda, esta matriz debe ser de tamao NDx2, 
% donde ND indica el nmero de dimensiones y 2 por el lmite superior
% e inferior de cada dimensin. Por ejemplo en 3D se tendra una matriz
% bnd de 3x2 definida como:
%
%   bnd = [ x_lmite_inferior x_lmite_superior
%           y_lmite_inferior y_lmite_superior
%           z_lmite_inferior z_lmite_superior ];
%%

function X = Seeder(bnd)
% Una primera implementacin de distribucin aleatoria en el espacio 
% factible es la siguiente:
X(1,:) = bnd(:,1) + rand(size(bnd,1),1).*(bnd(:,2) - bnd(:,1));

% Otra un poco ms tradicional es la que sigue a continuacin (si desea 
% usarla, descomntela). Esta es til en particular para cuando adems
% de la restriccin tradicional por lmites, se tienen restricciones o
% fronteras como funciones.

% blo = bnd(:,1); bup = bnd(:,2); dim = size(bnd,1); 
% X = zeros(1,Dimensions); 
% for d = 1 : Dimensions, X(1,d) = blo(d) + rand*(bup(d) - blo(d)); end
