% Runs the MCMC sampler for each participant separately.
%
% Runs the MCMC sampler to generate a posterior parameter distribution for
% each experimental participant separately.
%
% Arguments:
%  o data - the data structure for all participants
%  o num_iter - the (optional) number of iterations for which to sample.
%               Defaults to 2000 if no value is provided.
%  o print_iter - the (optional) number of iterations between displaying 
%                 updates. Defaults to 1000 if no value is provided.
%
% Returns: 
% o logprobs - a matrix of log probabilities for each MCMC sample for each
%              participant.
% o qqs - a cell array of samples for each participant.
% o accs - a vector of how many updates were made on each sample for each
%          participant
function [logprobs,qqs,accs] = indiv_subj_test(data,num_iter,print_iter)

num_subjs = length(data);

if nargin < 2
    num_iter = 2000;
end
if nargin < 3
    print_iter = 1000;
end

logprobs = zeros(num_iter,num_subjs);
qqs = cell(num_iter,num_subjs);
accs = zeros(num_iter,num_subjs);

for subj = 1:num_subjs
    
    dpm = dpm_init(1,1,data(subj),randi(1,1));

    for iter = 1:num_iter

        logprobs(iter,subj) = logprobdpm(dpm);
        qqs{iter,subj} = dpm.qq{1};

        if mod(iter,print_iter) == 0

            disp(['subj: ' num2str(subj), ', iter: ' num2str(iter), ...
                ', logprob: ' num2str(logprobs(iter,subj))])
        end

        [dpm,accs(iter,subj)] = one_subj_mh(dpm);
    end
end
end