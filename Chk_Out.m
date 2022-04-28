% Funcin para verificar si se debe detener el algoritmo
%
%   Fx: vector con valores de fitness
%   Epsilon: Tolerancia aceptable para convergencia
%   J: Iteraciones ejecutadas
%   MaxJ: Mximo de iteraciones permitidas
%   ContSat: Contador para salida por saturacin
%   LastFx: ltimo ptimo encontrado
%   MaxSat: Iteraciones mximas permitidas para salida por saturacin
%%
function [ExFlag,ContSat,LastFx]=Chk_Out(LastFx,Fx,Epsilon,J,MaxJ,...
    ContSat,MaxSat)
ExFlag = 0; % Seguir iterando
if  J == MaxJ
    ExFlag = -1;
%     return;
elseif min(abs(Fx)) <= Epsilon
    ExFlag = 1;
%     return;
elseif min(abs(Fx)) < abs(LastFx)
    ContSat = 0; % Reiniciar contador
    LastFx = Fx;
else
    ContSat = ContSat + 1;
    if ContSat == MaxSat
        ExFlag = 2;
        ContSat = 0;
%         return;
    end
end   