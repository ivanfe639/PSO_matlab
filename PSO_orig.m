%% PSO BASIC - PSO BSICO
%
% Developed by Jorge Cruz, Eng.
% Advised by Rodrigo Correa, Ph.D. and Ivn Amaya, Ph.D(c).
%
% CEMOS Research Group - Grupo de Investigacin CEMOS
% Universidad Industrial de Santander
% Bucaramanga - Santander - Colombia
% 14 - Oct - 2012

function [Pg,fPg,j] = PSO(fObj,Nd,bnd,Na,Epsilon)

% Nmero mximo de pasos y saturacin
MaxJ = 1e10;
MaxSat = 1e3;
% Define PSO parameters
cp = 2.05;
cg = 2.05;
w = 0.7;

% Inicializa el contador de pasos y el de saturacin
j = 0; s = 0;

% Prealocacin de X y F
fPi = nan(Nd,1);
% X = nan(Na,Nd);

fPi_last = inf;

% Inicializacin de X y F
for i = 1 : Na, X(i,:) = Seeder(bnd), end
for i = 1 : Na, fPi(i) = fObj(X(i,:)); end

% Initialize the particle's velocity
V = zeros(Na,Nd);

% Inicializacin de la mejor posicin Pi y  f(Pi) = fPi
Pi = X;

% Inicializacin de la mejor posicin Pg y f(Pg) = fPg
[fPg,g] = min(fPi); Pg = X(g,:),

% Validacin de las posiciones obtenidas
[ExFlag,s,fPi_last] = Chk_Out(fPi_last,fPg,Epsilon,j,MaxJ,s,MaxSat);

%% Inicia proceso principal
while ExFlag == 0,
    
    % Actualiza el contador de pasos
    j = j + 1;
    
    % Ecuaciones propias del mtodo PSO
    for i = 1 : Na,
        for d = 1 : Nd,
            V(i,d) = w*V(i,d) + ...
                cp*rand*(Pi(i,d) - X(i,d)) + ...
                cg*rand*(Pg(d) - X(i,d));
        end
        
        % Actualiza la posicin de la partcula
        X(i,:) = X(i,:) + V(i,:);
        
        % Verifica y corrige que se encuentre dentro del dominio
        X(i,:) = Chk_Feas(X(i,:),bnd,2);
        
        % Actualiza Pi
        fX = fObj(X(i,:));
        if (fX < fPi(i)),
            fPi(i) = fX;
            Pi(i,:) = X(i,:);	
            
            end
    end
    
    % Actualiza Pg
    [fX,i] = min(fPi);
    if (fX < fPg),
        fPg = fX,
        Pg(:) = X(i,:),
    end
    
    
    % Validacin de las posiciones obtenidas
    [ExFlag,s,fPi_last] = Chk_Out(fPi_last,fPg,Epsilon,j,MaxJ,s,MaxSat);
    
    % Comentar si se quiere rapidez
    Animate(X,fPi,.45,bnd,'prueba PSO',j)
end