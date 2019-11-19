%                       newtonRoot.m
%
% A Matlab script that implements Newton's method for 
% finding the roots of the non-linear equation x^2 - 2.0
%
% This is not a robust code - there is no code that 
% terminates the iteration if too many iterates are taken. 
%

% (test)
% fstring = 'x^2-2';
% dfstring = '2*x';

% (a)
fstring = 'sin(x/2)-1';      % target function 
dfstring = '1/2*cos(x/2)';       % target functions derivative

% (b)
% fstring = 'exp(x)-tan(x)';      % target function 
% dfstring = 'exp(x)-sec(x)^2';       % target functions derivative

% (c)
% fstring = 'x^3-12*x^2+3*x+1';      % target function 
% dfstring = '3*x^2-24*x+3';       % target functions derivative



x0  = 1;               % initial guess
eps = 1.0e-12;             % stopping tolerance
format long;              % print out in long format
format compact;           % suppress line feeds

xn  = x0;

eval(['x = xn;',fstring,';']);     % evaluate f  at xn
fn = ans; 
eval(['x = xn;',dfstring,';']);    % evaluate f' at xn
dfn = ans; 

iter = 0;
errEst = 0;

while(abs(fn) > eps)      
   xn  = xn - fn/dfn;      % Newton iteration
   
   sprintf(['Approximate root is %-15.10f'],xn) 
   
   eval(['x = xn;',fstring,';']);     % evaluate the f  at xn
   fn = ans; 
   eval(['x = xn;',dfstring,';']);    % evaluate the f' at xn
   dfn = ans; 
   
   iter = iter + 1;
   
   errEst = fn/dfn;
end


%
% Print out final results
%
disp(sprintf(['Approximate root of %s    : %-15.10f '],fstring,xn))
disp(sprintf(['Initial iterate           : %-15.10f '],x0))
disp(sprintf(['Residual                  : %-15.10e '],fn))
disp(sprintf(['Approximation error bound : %-15.10e'],errEst))  %%%????
disp(sprintf(['Iterations required       : %-5d'],iter))