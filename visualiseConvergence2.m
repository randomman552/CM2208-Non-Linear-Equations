% CM2208, George Grainger
% Task 6
% f - Function to evaluate in the form of an anonymous function
% df - Derivative of the function to evaluate, as anonymous function
% rsltn - Target square resolution of the resulting image, default is 400
function visualiseConvergence2(f, df, imgRes)
    if nargin < 3
        imgRes = 400;
    end
    
    % Function for getting unique colors
    function col = getNthUniqueColor(n, maxN)
       hue = ((360 / maxN) * n)/360;
       sat = 1;
       val = 1;
       
       col = hsv2rgb([hue, sat, val]);
    end
    
    % Function to create image from results
    function img = createImage(res, attempts)
        imgSize = size(res, 1);
        baseImg = ones(imgSize, imgSize, 3);
        
        % Apply different colours to each root
        % First find how many roots we have
        resUnique = unique(round(res(~isnan(res)), 3));
        
        % Make an image for each and combine into the final img
        img = zeros(size(baseImg));
        for k = 1:length(resUnique)
            uniqueMask = round(res, 3) == resUnique(k);
            
            % Apply unique color
            color = getNthUniqueColor(k, length(resUnique));
            baseImg(:, :, 1) = color(1);
            baseImg(:, :, 2) = color(2);
            baseImg(:, :, 3) = color(3);
            
            % Add to image
            img = img + bsxfun(@times, baseImg, cast(uniqueMask, "like", baseImg));
        end
        
        % Finally, apply mask for number of attempts
        baseImg = ones(imgSize, imgSize, 3);
        attemptsLog = log(attempts);
        attemptsMask = attemptsLog / max(max(attemptsLog));
        img = (img / 2) + (bsxfun(@times, baseImg, cast(attemptsMask, "like", baseImg)) / 2);
        
        % Apply grey to areas of non-convergence (done afterwards so
        % attempts mask doesn't change it
        greyMask = isnan(res);
        img(greyMask) = 0.5;
    end
    
    % Get results
    aRange = -1:2/imgRes:1;
    bRange = -1:2/imgRes:1;
    nRes = zeros(imgRes, imgRes);
    oRes = zeros(imgRes, imgRes);
    nAtmps = zeros(imgRes, imgRes);
    oAtmps = zeros(imgRes, imgRes);
    for i = 1:length(bRange) - 1
       for j = 1:length(aRange) - 1
           x = aRange(j) + bRange(i) * 1i;
           [nRes(i, j), nAtmps(i, j)] = Newton(f, df, x, 1e-5, 100);
           [oRes(i, j), oAtmps(i, j)] = Ostrowski(f, df, x, 1e-5, 100);
       end
    end
    
    % Create images
    nImg = createImage(nRes, nAtmps);
    oImg = createImage(oRes, oAtmps);
    
    subplot(1, 2, 1);
    imshow(nImg);
    title("Newton");
    
    subplot(1, 2, 2);
    imshow(oImg);
    title("Ostrowski");
end