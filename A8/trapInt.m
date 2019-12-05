%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                Math 151A       trapInt.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This function returns the result of applying the composite
%  trapezoidal rule to a function over the interval [a,b] using n panels.
%
%  On entry : F        = Function handle for function being integrated  
%             a        = left integration endpoint
%             b        = right integration endpoint
%             n        = number of panels to use in the integration formula
%
%  Returned : the approximate value of the integral. 
%
%  2/21/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [y] = trapInt(F, a, b, n)

h   = (b-a)/n;
sum = 0.0;

for i = 0:n-1
   x_i = a+i*h;
   x_j = a+(i+1)*h;
   sum = sum + (F(x_i)+F(x_j))*h/2;
   
   %x_i = i*h;
   %sum = sum + F(x_i)*h;
end

y = sum;

