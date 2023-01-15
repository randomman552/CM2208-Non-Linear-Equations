% CM2308 CW, George Grainger.
% Task 2
% f - A function, in the form of an anonymous function.
% df - The derivative of the function, annonymous function again.
% N - Maximum number of iterations.
function visualiseConvergence1(f, df, N)
    % Range for values to be computed for
    x = -10:20/1000:10;
    y = zeros(1, length(x));
    nRes = zeros(1, length(x));
    oRes = zeros(1, length(x));

    for i = 1:length(x)
       y(i) = f(x(i));
       [nRes(i), n] = Newton(f, df, x(i), 1e-5, N);
       [oRes(i), n] = Ostrowski(f, df, x(i), 1e-5, N);
    end
    
    % Plot for Newton's method
    subplot(1, 2, 1);
    failLine = y;
    failLine(~isnan(nRes)) = NaN;
    plot(x, y, "b", x, failLine, "r");
    title("Newton");
    
    % Plot for Ostrowski's method
    subplot(1, 2, 2);
    failLine = y;
    failLine(~isnan(oRes)) = NaN;
    plot(x, y, "b", x, failLine, "r");
    title("Ostrowski");

    sgtitle("Newton vs Ostrowski");
end