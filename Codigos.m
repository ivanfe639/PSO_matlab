[X,Y] = meshgrid(linspace(0,2*pi,50));
Z = 10*sin(3*sqrt(X.^2+Y.^2)).*exp(-sqrt((X + 1).^2+(Y - 1).^2));
surf(X,Y,Z), shading interp, 
%%
f = @(X) 10*sin(3*sqrt(X(1).^2+X(2).^2)).*...
    exp(-sqrt((X(1) + 1).^2+(X(2) - 1).^2));
% figure,
% [Pg,fPg,j] = PSO(f,2,[0 6;0 6],100,1e-3)
[BHP,BHF,j,t,outmsg,HistBW] = HS_Orig(f,2,[0 6;0 6],10,0.8,0.8,0.8);
BHP,BHF,j,t,outmsg