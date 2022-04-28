%% Funcin Animate
% Funcin para mostrar en 2D  3D la variacin de los agentes en el
% dominio de bsqueda. Como argumentos de entrada se tienen:
%
%   X   - Matriz de Na (filas) agentes con Nd (columnas) dimensiones
%   dt  - Paso de tiempo en segundos para la visualizacin
%   name - Etiqueta adicional para la grfica
%%
function Animate(X,Y,dt,bnd,name,t)

if nargin < 6,
    t = -1;
    if nargin < 5,
        name = 'optimizacin funcin Y con el mtodo X';
        if nargin < 4,
            bnd = [min(X,[],1);max(X,[],1)]';
            if nargin < 3,
                dt = 0.25;
                if nargin < 2,
                    warning('No se han ingresado valores para graficar.');
                    return;
                end
            end
        end
    end
end

% Definicin de propiedades en la figura
set(gcf,'Renderer','painters',...
    'Name',['Grfica ',name],'Color',[1 1 1],...
    'Units', 'normalized','Position', [.04,.12,.6,.65]);
% newax = axes;

% Tipo de marcador y color
mkr = 'ko';
% copyobj(haxes,newax);

% Seleccin del tipo de grfica (2D  3D)
Nad = size(X);
switch Nad(2),
    case 1,
        plot(X,Y,mkr,'MarkerFaceColor',rand*[1 1 1],'MarkerSize',10);
        hx = xlabel('X_{1}'); hy = ylabel('f_{Obj}'); hz = [];
    case 2,
        plot(X(:,1),X(:,2),mkr,'MarkerFaceColor',rand*[1 1 1],...
            'MarkerSize',10); hx = xlabel('X_{1}');
        hy = ylabel('X_{2}'); hz = zlabel('f_{Obj}');
    otherwise,
        warning(['No es posible graficar para ',num2str(Nad(2)),'D']);
end

% Opciones adicionales de la grfica
set(gca,'YMinorTick','on','XMinorTick','on','ZMinorTick','on',...
    'LineWidth',1.5,'FontSize',14,'FontName','tahoma','Color',[1 1 1],...
    'box','off');

ht = []; if t ~= -1, title(['Paso t = ',num2str(t)]); end
set([hx,hy,hz,ht],'FontName','tahoma','FontSize',14);
axis([reshape(bnd',1,Nad(2)*2)]);

pause(dt);