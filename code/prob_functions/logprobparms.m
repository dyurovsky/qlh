% Calculates probability of cluster parameters given a jeffreys prior
%
% Calculates the probability of a parmeterization given that all parameters
% are drawn from independent gaussians with mean zero and standard
% deviation given from jeffreys prior (1/|sigma|)
%
% Arguments:
% o dpm - the DPM structure containing parmeters and observed data
%
% Returns: 
% o logprob - the log probability of the observed data | parms
function logprob = logprobparms(row_parms)

%correct for zero probability
SMALL = .001;

logprob = sum(-log(((abs(row_parms)+SMALL))));

end
