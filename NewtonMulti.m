% CM2208 CW, George Grainger.
% Task 3
% f - Function (must be symbolic)
function roots = NewtonMulti(f)
    plot([-10, 10], [0, 0], "k--")
    hold on;
    fplot(f, [-10, 10], "b");
    xlim([-10, 10])
    title("Roots of f");
    
    syms x;
    fi = f;
    dfi = diff(fi);
    roots = zeros(1, 0);
    for i = 1:10
        % Surround in try to prevent any zero division errors from crashing
        % the program
        try
            ri = Newton(fi, dfi, i - 1, 1e-5, 100);
            fi = fi / (x - ri);
            dfi = diff(fi);
            roots(end+1) = ri;
        catch
        end
    end
    % Remove any NaN's
    roots = roots(~isnan(roots));
    
    for i = 1:length(roots)
        plot(roots(i), subs(f, roots(i)), "ro");
    end
    hold off;
end