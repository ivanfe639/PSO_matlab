function y = f_prueba1(x)
y=10*sin(10*sqrt(x(1).^2 + x(2).^2)).*exp(-sqrt((x(1)+1).^2 + (x(2)-1).^2));
