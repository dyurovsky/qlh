% Calculates distance between two categorical histograms using the MDPA
%
% MDPA measures the distance between two categorical histograms. See:
% Cha, S., & Srihari, S. N. (2002). On measuring the distance between
%   histograms. Pattern Recognition, 35, 1355-1370.
%
% Arguments:
%  o hist1 - the first histogram
%  o hist2 - the second histogram
%
% Returns: 
% o mdpa - the distance between hist1 and hist2
function dist = mdpa(hist1,hist2)

%Truncates histograms if one has more categories than the other
if size(hist1,2) < size(hist2,2)
    hist2 = hist2(:,1:size(hist1,2));
elseif size(hist2,2) < size(hist1,2)
    hist1 = hist1(:,1:size(hist2,2));
end

dist = sum(max(hist1,hist2),2) - sum(min(hist1,hist2),2);

end