function [tout, yout] = ode(ypfun, t0, tfinal, y0, paso)
%ODE23	Solve differential equations, low order method.
%	ODE23 integrates a system of ordinary differential equations using
%	2nd and 3rd order Runge-Kutta formulas.
%	[T,Y] = ODE23('yprime', T0, Tfinal, Y0) integrates the system of
%	ordinary differential equations described by the M-file YPRIME.M,
%	over the interval T0 to Tfinal, with initial conditions Y0.
%	[T, Y] = ODE23(F, T0, Tfinal, Y0, TOL, 1) uses tolerance TOL
%	and displays status while the integration proceeds.
%
%	INPUT:
%	F     - String containing name of user-supplied problem description.
%	        Call: yprime = fun(t,y) where F = 'fun'.
%	        t      - Time (scalar).
%	        y      - Solution column-vector.
%	        yprime - Returned derivative column-vector; yprime(i) = dy(i)/dt.
%	t0    - Initial value of t.
%	tfinal- Final value of t.
%	y0    - Initial value column-vector.
%	tol   - The desired accuracy. (Default: tol = 1.e-3).
%	trace - If nonzero, each step is printed. (Default: trace = 0).
%
%	OUTPUT:
%	T  - Returned integration time points (column-vector).
%	Y  - Returned solution, one solution column-vector per tout-value.
%
%	The result can be displayed by: plot(tout, yout).
%
%	See also ODE45, ODEDEMO.

%	C.B. Moler, 3-25-87, 8-26-91, 9-08-92.
%	Copyright (c) 1984-94 by The MathWorks, Inc.

% Initialization
%pow = 1/3;
%if nargin < 5, tol = 1.e-3; end
%if nargin < 6, trace = 0; end

t = t0;
hmax = (tfinal - t)/paso;
h = paso;
y = y0(:);
chunk = round(hmax);
tout = zeros(chunk,1);
yout = zeros(chunk,length(y));
k = 1;
tout(k) = t;
yout(k,:) = y.';

while (t < tfinal) 
  
   % Compute the slopes
   s1 = feval(ypfun, t, y); s1 = s1(:);
   %s2 = feval(ypfun, t+h, y+h*s1); s2 = s2(:);
   %s3 = feval(ypfun, t+h/2, y+h*(s1+s2)/4); s3 = s3(:);
      t = t + h;
      %   y = y + h*(s1 + 4*s3 + s2)/6;
      y=y+h*s1;
      k = k+1;
      if k > length(tout)
         tout = [tout; zeros(chunk,1)];
         yout = [yout; zeros(chunk,length(y))];
      end
      tout(k) = t;
      yout(k,:) = y.';

tout = tout(1:k);
yout = yout(1:k,:);
end