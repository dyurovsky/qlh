% Calculates credible intervals and other statistics for model parameters
%
% Given a sequence of samples from the DPM distribution, calculates 
% Bayesian credible intervals and other statistics for model parameters.
% The size of the interval is specified by int_size
%
% Arguments:
%  o dpms - a cell array of MCMC samples from the DPM distribution
%  o int_size - the size of the credible interval (e.g. .95, .68)
%
% Returns: 
% o ints - credible intervals
% o nns - number of subjects in each group
% o meds - medians for model parameters
% o means - means for model parameters
% o stds - standard deviations for model parameters
function [ints nns meds means stds]= cred_int(dpms,int_size)

%Grabs the clusters from each sample
qqs = cellfun(@(x) x.qq, dpms,'UniformOutput', false);
qqs = vertcat(qqs{:});

%Grabs the number of subjects per cluster from each sample
nns = cellfun(@(x) x.nn, dpms,'UniformOutput', false);
nns = vertcat(nns{:});

%Calls the per-cluster credible interval function
[ints meds means stds] = ...
    arrayfun(@(x) cred_int_cluster(qqs(:,x),int_size), ...
    1:size(qqs,2), 'UniformOutput', false);
end