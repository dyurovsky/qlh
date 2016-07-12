% Generates data from the model given parameters and experimental structure
%
% Generates data from a parameterized participant model given experimental
% structure and values for each of the relevant parameters.
%
% Arguments:
%  o parms - the cognitive model paramater values from which to generate
%            the data
%  o structure -  the experimental settings for which to generate data
%
% Returns: 
% o data - A data structure for this generated data
function data = gen_data_pt(parms,structure)

base_alphas = get_base_alphas(parms,structure);
data = zeros(size(base_alphas));

words = get_words(structure);

habit = parms.habit_p;
habit_poly = [habit(end:-1:1) 0];
habit_times = zeros(size(data));

assoc = parms.assoc_p;
assoc_poly = [assoc(end:-1:1) 0];
assoc_times = zeros(size(data,1),size(data,2),2);

all_alphas = zeros(size(base_alphas));
for trial = 1:size(data,1)
    
    alphas = exp(base_alphas(trial,:) + ...
        polyval(habit_poly,habit_times(trial,:)) + ...
        polyval(assoc_poly,assoc_times(trial,:,words(trial))));
   
    all_alphas(trial,:) = alphas;
    
    gammas = gamrnd(alphas,1);
    data(trial,:) = gammas./sum(gammas);
    
    habit_times(trial+1,1:(end-1)) = habit_times(trial,1:(end-1)) + ...
        data(trial,1:(end-1));
    
    assoc_times(trial+1,1:(end-1),:) = assoc_times(trial,1:(end-1),:);
    
    assoc_times(trial+1,1:(end-1),words(trial)) = ...
        assoc_times(trial+1,1:(end-1),words(trial)) + ...
        data(trial,1:(end-1));
end
