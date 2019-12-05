% qSplineTest
%
% A program to test the accuracy of a quadratic
% spline approximation based upon data values at n+1 equispaced 
% knots over the interval [xMin,xMax].
%              
%
% Math 151A, Winter 2018 (03/08/2018)
%


F     = @(x)sin(x);  % Target test function 

xMin = 0.0;
xMax = 2.0;

nStart  = 10;       % Starting number of panels 

nRefine = 5;        % Number of refinements. 0 refinements 
                    % leads to a single construction with 
                    % nStart panels. 

for kStep = 1:nRefine+1

n     = nStart*2^(kStep-1);  % number of panels
h     = (xMax-xMin)/n;       % panel size 


% Create equispaced data samples

f = zeros(n+1,1);
x_ = zeros(n+1,1);

for i = 0:n
  x_(i+1)    = xMin + i*h;
  f(i+1) = F(x_(i+1));
end


% Data allocation for spline coefficients using a spline 
% representation over the ith panal of 
%
% S_i(x) = a(i) + b(i)*(x - x_(i-1)) + c(i)*(x - x_(i-1))^2
%

a     = zeros(n,1);  
b     = zeros(n,1); 
c     = zeros(n,1); 

% 
% Data allocation for n+1 equations for the q(i) values where 
% q(i) = S'(x_(i-1)) i = 1 .. n + 1 
%

q     = zeros(n+1,1);     
A     = zeros(n+1,n+1);  % Matrix determining q values
qRHS  = zeros(n+1,1);  % Right hand side of equations for q


% Set up A and qRHS, the equations for the q(i) values  
for i = 2:n+1
    for j = i-1:i
        A(i,j) = 1;
    end
end
A(1,1) = 1;

qRHS(1) = cos(0);
% qRHS(1) = 0;
% qRHS(1) = (sin(x_(2))-sin(x_(1)))/h;
% qRHS(1) = (-sin(x_(3))+4*sin(x_(2))-3*sin(x_(1)))/(2*h);

for i = 2:n+1
    qRHS(i) = 2/h*(f(i)-f(i-1));
end

% Solve the system 

q = A\qRHS;

% Determine the values of the coefficients
% a(i), b(i) and c(i) for i = 1 .. n from the q(i) values.
%

for i = 1:n
    a(i) = f(i);
    b(i) = q(i);
    c(i) = (q(i+1)-q(i))/(2*h);
end

% Evaluate the spline at 200 equispaced points 

nSample = 200;
x       = xMin:(xMax-xMin)/nSample:xMax;

s       = qSplineEval(x,a,b,c,xMin,xMax); % spline evaluation

exactF = F(x);                            % exact  evaluation 


% Evaluate the max of the error over sampling points 
% and store the error in the vector splineErrorNorm 

splineError            = s - exactF;
splineErrorNorm(kStep) = norm(splineError,inf);

fprintf('Panels : %-3d  Error Max:  %-15.10e \n',n,splineErrorNorm(kStep));


plot(x,exactF,x,s);
axis([xMin,xMax,-0.5,1.5]);
legend('y = sin(x)','y = spline approximation');

% Pause the computation after each refinement step so that 
% one can view the plots 

fprintf ('press any key to advance to next refinement \n');
pause



end % End of loop over refinements 

%
% End of computation loop 
%

% Process the error 
err = zeros(nRefine+1,1);
p = zeros(nRefine,1);
fs = [' # panels            Error   ',sprintf('\n')];

for kStep = 1:nRefine+1
  n  = nStart*2^(kStep-1);
  fs = [fs,sprintf('  %-3d                %-15.10e \n',n,splineErrorNorm(kStep))];
  err(kStep) = max(splineErrorNorm(kStep));
end

for i = 1:nRefine
    p(i) = log(err(i)/err(i+1))/log(2);
end
fs
p
