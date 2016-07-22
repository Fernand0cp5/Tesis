syms A B C D E F G H s0 x 
nuden1 = A*((C/2)*atan((C*x/sqrt(H^2-x^2)))-1/2*asin(x/H)+(C/2)*atan(F*x));
nuden2 = B*(D*atan((C*x/sqrt(H^2-x^2)))-E*asin(x/H)+D*atan(F*x)-x/2);
d1 = 1/2*(-sqrt(H^2-x^2)*x+G*x-H^2*asin(x/H));
den = (nuden1-nuden2)/d1;
vec_pos = sin(acos((den*G-B)/(2*H*den)));
deriv = diff(vec_pos,x)

