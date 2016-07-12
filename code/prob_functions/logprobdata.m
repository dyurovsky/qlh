% Calculates probability of observed data given a model parameters
%
% Calculates the probability of the observed data being drawn from a
% Dirichlet distribution whose parameters are calculated for each trial
% from parms and the experimental settings.
%
% Arguments:
% o data_pt - the observed data
% o parms - prameters for this cluster
%
% Returns: 
% o logprob - the log probability of the observed data | parms
function logprob = logprobdata(data_pt,parms)

% Correct for 0 probability
SMALL = .00001;

%get Dirichlet parameters for each trial from parms and trial structure
alphas = get_alphas(data_pt,parms);

% likelihood:
% Sum<trials>[
%   Sum<boxes>[ 
%     (alphas(trial,box)-1)*log(data(trial,box)) 
%      - logGamma(alphas(trial,box))]
%   + logGamma(Sum<boxes>[alphas(trial,box)])]
logprob = sum(sum((alphas+SMALL - 1) ...
    .* log(min(data_pt.data+SMALL,ones(size(data_pt)))) ...
    - gammaln(alphas+SMALL),2) + gammaln(sum(alphas+SMALL,2)));

end
