% CM2208 Newton's Method
% Removed print statements to improve performance
% Input: function f, df (derivative of f), initial guess p0, 
% tolerance (as relative error)
% N0 (max. iterations)
% Output: [p, n] where p is the result, and n is number of iterations
function [p, n] = Newton(f, df, p0, TOL, N0)
% Check if f or df are symbolic inputs, and convert them to functions if so
if ~isnumeric(f(1))
    f = @(x) double(subs(f, x));
end
if ~isnumeric(df(1))
    df = @(x) double(subs(df, x));
end

%Step 1:
i = 1;
%Step 2:
while i <= N0
   %Step 3:
   p = p0 - f(p0)/df(p0);
   %Step 4:
   % Additional check to prevent NaN from beign returned
   if abs(p - p0) < TOL
       n = i;
       return;
   elseif isnan(p)
       n = N0;
       return;
   end
   %Step 5:
   i = i + 1;
   %Step 6:
   p0 = p;  
end
% Assign p as NaN so we know that it failed.
p = NaN;
n = N0;

end