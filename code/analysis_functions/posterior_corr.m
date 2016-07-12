% Calculates the correlation between DPM predictions and empirical
% data for a whole DPM distribution
%
% Generates predictions from a DPM parameterization and compares them to 
% the empirical data used to fit DPM parameters. Computes mean correlation.
%
% Arguments:
%  o dpms - a cell array of MCMC samples from the DPM distribution
%  o test_flag - a boolean that determines if all or only test data are
%                used to compute correlations
%
% Returns: 
% o c - correlation between predictions and empirical data
% o p - significance of the correlation
function [c p] = posterior_corr(dpms,test_flag)

    [c ps] = cellfun(@(x) dpm_corr(x,test_flag),dpms);

    c = mean(c);
    p = mean(ps);

end