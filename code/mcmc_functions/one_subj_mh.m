% Runs one round of Metropolis-Hastings Sampling for a single subject DPM
%
% Runs MCMC for a single-subject. No need to deal with the DP part of the
% model. Just resamples cognitive model parameters and calculates 
% likelihoods ignoring concentration parameter, etc.
%
% Arguments:
% o dpm - a single-subject sample from the DPM probability distribution
%
% Returns: 
% o dpm - the new DPM sample after MH
% o acc - the number of clusters whose parameters changed in this round 
function [dpm,acc] = one_subj_mh(dpm)
% run one iteration of MH sampling in the DP mixture

KK = dpm.KK; % number of active clusters
qq = dpm.qq; % row cell vector of mixture components
xx = dpm.xx; % row cell vector of data items
zz = dpm.zz; % row vector of cluster indicator variables
nn = dpm.nn; % row vector of number of data items per cluster

% resample thetas
acc = 0;
for kk = 1:KK
    qq_p = propose_parms(qq{kk},0,.5);
    
    xs = xx(zz==kk);
    
    y = sum(cellfun(@(pt) logprobdata(pt,qq{kk}), xs)) + qq{kk}.logprior;
    y_p = sum(cellfun(@(pt) logprobdata(pt,qq_p), xs)) + qq_p.logprior;
    
    rat = y_p - y;
    
    if (rat > 0) || (log(rand) < rat)
        qq{kk} = qq_p;
        acc = acc + 1;
    end
end

% save variables into dpm struct
dpm.qq = qq;
dpm.zz = zz;
dpm.nn = nn;
dpm.KK = KK;

end
