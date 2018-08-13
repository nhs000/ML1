function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    % true positive
    tp = sum(((pval < epsilon) .* (yval == 1)) > 0);
    % false positive
    fp = sum(((pval < epsilon) .* (yval == 0)) > 0);
    % false negative
    tn = sum(((pval >= epsilon) .* (yval == 1)) > 0);

    if( tp + fp == 0)
        continue
    end
    if (tp + tn == 0)
        continue;
    end
    prec = tp / (tp + fp);
    rec = tp / (tp + tn);
    
    if (prec + rec == 0)
        continue;
    end

    F1 = (2 * prec * rec ) / (prec + rec);

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
