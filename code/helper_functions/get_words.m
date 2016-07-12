% Gets the word heard on each trial from a structure representation
%
% Arguments:
% o mat - the structure represenation of experimental settings
%
% Returns: 
% o words - A vector representation of the word heard on each trial
function words = get_words(mat)
    words = mat(:,end);
end