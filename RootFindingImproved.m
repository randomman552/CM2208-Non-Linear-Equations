% CM2208CW, George Grainger.
% Task 5
% f - Function f as an anonymous function
% df - Derivative of f as an anonymous function
function p = RootFindingImproved(f, df)
    % Initial range
    a = -10;
    b = 10;
    
    [a, b] = BisectionInitialise(f, a, b);
    p = Bisection(f, a, b, 1e-5, 5);
    p = Ostrowski(f, df, p, 1e-5, 100);
end