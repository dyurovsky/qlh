% Gets whether each AOI is cued on each trial
%
% Cued is representated as binary on/off
%
% Arguments:
%  o mat - the structure represenation of experimental settings
%
% Returns: 
% o cued - a matrix of the cue status of each AOI on each trial
function cued = iscued(mat)
   cued = [mat(:,1:(end-1)) > 1 zeros(size(mat,1),1)];
end