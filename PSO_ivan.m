% programa PSO
% 1) primer paso defino los valores iniciales de x y v
clc
clear all
close all
%Inicializacion
bnd=[-2 6
     -2 6 ];
 
 particulas=30;
 iteraciones=100;

 V=zeros(particulas,2);
 
 % parámetros PSO
 w=0.6; 
 c1=2.05;
 c2=2.05;
% stop=1e-3; 

 for i=1:particulas
 X(i,:) = Seeder(bnd);  	%presenteX
 Z(i)=f_prueba1(X(i,:));	%Imagenes de presenteX
 end
  
 % 2) Encontrar valores de Pi y  Pg
 Pi=X;    %los mejores valores de X pbestx

[Y,I]=min(Z);    %Guarda el valor y la posicion del mejor osea el minimo de las imagenes
Pg=X(I,:);  %guarda los valores del mejor 'gbest'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%aca voy
for j=1:iteraciones

% 3) Actualizar posicion y velocidad
for i=1:particulas

r1=rand(1);
r2=rand(1);

V(i,:)=w*V(i,:) + c1*r1*(Pi(i,:)-X(i,:)) + c2*r2*(Pg-X(i,:));
Xt=X(i,:) + V(i,:);

% Evalua si el valor está dentro de la frontera
Xt=Chk_Feas(Xt,bnd,1);
Yt=f_prueba1(Xt);

% Evalua si el nuevo valor es mejor para actualizar la posicion de la
% particula
    if Z(i) > Yt
        X(i,:)=Xt;
    end
        
% 4) Obtener el nuevo Pi
Zp=f_prueba1(X(i,:));

    if Z(i)>Zp
        Pi(i,:)=X(i,:);	
        Z(i)=Zp;
%    else
%       Pi(i)=Pi(i);
   end
    
% 5) Obtener el nuevo Pg
    
Yg=f_prueba1(Pg);

    if Yg > Zp
        Pg=X(i,:);
%    else
%        Pg=Pg;
   end
  
end
% 6) Evaluar criterio de parada

   % if abs(Yg)<stop
    %    break
   % end
 %Animate(X,Z,0.1,bnd,'PSO',j);

end
%f_prueba1([ -1.501357 , -2.000000 ])

disp('la respuesta debe ser [ -1.2147   1.2147]')
disp('Y dio: ')
disp(Pg)

