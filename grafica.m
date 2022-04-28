clc
clear all
contx=1;
conty=1;
paso=1;
lim_abajo=-50;
lim_arriba=50;

for  q=lim_abajo:paso:lim_arriba 
  conty=1;    
  for w=lim_abajo:paso:lim_arriba
    zz(contx,conty)=schaffer2([q,w]);
%    xx(cont1)=q;
 %   yy(cont1)=w;
    conty=conty+1;
   end	
    contx=contx+1;
end  

xx=lim_abajo:paso:lim_arriba;
yy=lim_abajo:paso:lim_arriba;
length(xx)
length(yy)
size(zz)
surf(xx,yy,zz) 	

