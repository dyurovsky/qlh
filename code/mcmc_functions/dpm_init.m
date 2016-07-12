% Initializes a Dirichlet Process Mixture (DPM) to known parameters
%
% Initializes a Dirichlet Process Mixture from known clusters or from the
% prior distribution for cluster parameters.
%
% Arguments:
% o KK - number of active clusters
% o aa - concentration parameter
% o xx - a cell array of data for each participant
%        format: x_i=xx{i}
% o zz - a vectir of initial cluster assignments for each participant
% o qq - (optional) pre-defined clusters
%
% Returns: 
% o dpm - the initialized DPM
% o structure - the model's representation of the experimental settings for
%               each trial of the experiment
%
% Based on the implementation by Yee Whye Teh
function dpm = dpm_init(KK,aa,xx,zz,qq)
% initialize DP mixture model, with 
% KK active mixture components,
% aa concentration parameter,
% xx data, x_i=xx{i}
% zz initial cluster assignments (between 1 and KK).
dpm.KK = KK;
dpm.NN = length(xx);
dpm.aa = aa;
dpm.xx = xx;
dpm.zz = zz;
dpm.nn = zeros(1,KK);

% initialize mixture components
if nargin < 5
    dpm.qq = cell(1,KK);
    for kk = 1:KK
        dpm.qq{kk} = parms_init();
    end
    
else %use pre-defined clusters
    dpm.qq = qq;
end

% add data items into mixture components
for ii = 1:dpm.NN
  kk = zz(ii);
  dpm.nn(kk) = dpm.nn(kk) + 1;
end

