% Calculates the correlation between DPM predictions and empirical
% data for a single DPM
%
% Generates predictions from a DPM parameterization and compares them to 
% the empirical data used to fit DPM parameters.
%
% Arguments:
%  o dpm - a single MCMC sample from the DPM distribution
%  o test_flag - a boolean that determines if all or only test data are
%                used to compute correlations
%
% Returns: 
% o c - correlation between predictions and empirical data
% o p - significance of the correlation

function [c p] = dpm_corr(dpm,test_flag)

    data_pts = arrayfun(@(x) dpm.xx{x}.data,1:dpm.NN, ...
        'UniformOutput', false);
    data_pts = vertcat(data_pts{:});
    
    gen_pts = arrayfun(@(x) gen_data_pt(dpm.qq{dpm.zz(x)}, ...
        dpm.xx{x}.structure), 1:dpm.NN, 'UniformOutput', false);
    gen_pts = vertcat(gen_pts{:});
    
    if test_flag
        gen_pts = gen_pts(7:7:end,:);
        data_pts = data_pts(7:7:end,:);
    end

   [c p] = corrcoef(data_pts,gen_pts);
   c = c(1,2);
   p = p(1,2);

end