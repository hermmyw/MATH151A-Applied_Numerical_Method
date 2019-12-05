%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 		      Math 151A  IntegateTest.m               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% An Matlab script that tests the composite Trapezoidal rule routine 
% for approximating the integral of a function over an interval [a,b].
%
% The composite trapezoidal routine is contained in the file 
% trapInt.m.  
%
% 2/21/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Target Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% F  = @(x)x^2;
% F = @(x)sin(x);
 F  = @(x)exp(-1*x^2);
% F  = @(x)x^(5/2);
% F  = @(x)x^(-1);
%                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Main Routine 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
a = 0.0;                    % integral from [a,b]
b = 2.0;
y = sqrt(pi)*erf(2)/2;

nRefine = 12;                     % number of refinements
intApp  = zeros(nRefine,1);      % array to hold results for each refinement
                                 % computed approximations to the integral
err = zeros(nRefine,1);
p = zeros(nRefine,1);
for i = 1:nRefine                 
	 nPanels   = 2^i;
	 intApp(i) = trapInt(F,a,b,nPanels);
     err(i) = intApp(i)-y;
end

for i = 1:nRefine-2
    p(i) = log((intApp(i+1)-intApp(i))/(intApp(i+2)-intApp(i+1)))/log(2);
end

%
% Print out the error. 
% The fs = [fs, ... ] construction creates one long string variable 
% fs that has all of the output contained in it. 
% ([ ...] is the string concatenation operator.)
% After the loop, fs is printed to display the results. 
% This construction avoids printing out extraneous carriage returns and
% lines with "ans =" in them. 
%
fs = [' # panels        Integral           Order' ,sprintf('\n')];
for(i = 1:nRefine)
   nPanels   = 2^i;
   fs =[fs,sprintf('  %-3d            %-15.10e   %-3d\n',nPanels,intApp(i),p(i))];
end
fs   % display the results
