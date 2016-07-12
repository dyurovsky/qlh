% Gets the latent association value for each AOI on each trial
%
% Gets the latent association values for each AOI for each trial.
% Association for location l in the presence of word w is defined as
% cumulative looking to l in the presence of w up to this trial.
%
% Arguments:
%  o data - a single participant's looking data
%  o structure - experimental settings for this participant, i.e. which
%                word is heard and which locations are filled on each trial
%
% Returns: 
% o assoc_mat - latent association for each AOI for each trial
function assoc_mat = get_assoc_mat(data,structure)

words = get_words(structure);
word_assoc_mat = zeros(size(data,1),size(data,2),2);
assoc_mat = zeros(size(data));

for word = 1:2
    word_inds = find(words == word);
    word_data = zeros(size(data));
     
    word_data(word_inds(2:end),:) = data(word_inds(1:(end-1)),:);
    word_assoc_mat(:,:,word) = cumsum(word_data);
    
    assoc_mat(word_inds,:) = word_assoc_mat(word_inds,:,word);
    
end

assoc_mat(:,end,:) = 0; %association set to zero for offscreen AOI
end
