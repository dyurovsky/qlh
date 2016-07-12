% Calculates probability of observed data given a parameterized DPM
%
% Calculates the probability of the observed data being drawn from all
% participants given a parameterized DPM.
%
% Arguments:
% o dpm - the DPM structure containing parmeters and observed data
%
% Returns: 
% o logprob - the log probability of the observed data | parms
function logprob = logprobdpm(dpm)

global NUM_PARMS;

logprob = 0;

% prob data | cluster thetas
for data_pt = 1:dpm.NN
    logprob = logprob+logprobdata(dpm.xx{data_pt},dpm.qq{dpm.zz(data_pt)});
end

% prob cluster thetas | theta_prior
for cluster = 1:dpm.KK
        logprob = logprob + dpm.qq{cluster}.logprior;
end

%fix normalization constant
logprob = logprob + (dpm.NN-dpm.KK)*logprobparms(zeros(1,NUM_PARMS));

% prob cluster assignments | CRP
logprob = logprob + logprobcrp(dpm.nn,dpm.aa);

%prob alpha
logprob = logprob - explike(1,dpm.aa);

end
