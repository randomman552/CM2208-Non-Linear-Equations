% CM2208CW, George Grainger.
% Task 4
% f - Function in form of an anonymous function
% a - Inital minimum value
% b - Inital maximum value
function [x1, x2] = BisectionInitialise(f, a, b)
    desiredRange = 1/(2^20) * (b - a);
    
    while b - a > desiredRange
        % First check if f(a) and f(b) have opposite signs
        if ((f(a) > 0) && (f(b) < 0)) || ((f(a) < 0) && (f(b) > 0))
            break;
        else
            % If not then test the f(m) against f(b)
            m = (a + b) / 2;
            if ((f(m) > 0) && (f(b) < 0)) || ((f(m) < 0) && (f(b) > 0))
                a = m;
            else
                b = m;
            end
        end
    end
    
    x1 = a;
    x2 = b;
end