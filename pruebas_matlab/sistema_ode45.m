% Sistemas de ecuaciones diferenciales de primer orden resolviendo con ode45
a = input('parametro a: ');
b = input('parametro b: ');
%condiciones iniciales en el vector x0
% x0 = zeros(1,2);
x0(1) = input('valor inicial de x: ');
x0(2) = input('valor inicial de y: ');
tf = input('tiempo final, tf: ');
tspan = [0 tf]
fg = @(t,x) [-a*x(1);a*x(1)-b*x(2)];%x(1) es x, x(2) es y
[t,x] = ode45(fg,tspan,x0);
plot(t,x)
xlabel('t')
ylabel('x,y');
title('dx/dt=-ax, dy/dt=ax-by')




