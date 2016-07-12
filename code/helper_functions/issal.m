% Gets whether each AOI is salient on each trial
%
% Salient is representated as binary on/off
%
% Arguments:
%  o mat - the structure represenation of experimental settings
%
% Returns: 
% o sals - a matrix of the salient status of each AOI on each trial
function sals = issal(mat)
    sals = [(mat(:,1:(end-1)) > 0) zeros(size(mat,1),1)];
end