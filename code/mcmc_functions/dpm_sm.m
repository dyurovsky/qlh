% Runs one round of Split-Merge Sampling for a DPM
%
% Picks splitting or merging with equal likelihood. Picks the newly
% obtained DPM according to a MH proposal distribution. See:
% Jain, S., & Neal, R. M. (2007). Splitting and merging components of a
%   nonconjugate Dirichlet process mixture model. Bayesian Analysis, 2,
%   445-472.
%
% Arguments:
% o dpm - a sample from the DPM probability distribution
%
% Returns: 
% o dpm - the new DPM sample after MH
% o acc - the number of clusters whose parameters changed in this round 
function [dpm,acc] = dpm_sm(dpm)
% run one iteration of Split/Merge in the DP mixture

NN = dpm.NN; % number of data items
zz = dpm.zz; % row vector of cluster indicator variables
nn = dpm.nn; % row vector of number of data items per cluster

acc = 0;
type = 0;

rds = randperm(NN);

clu_1 = zz(rds(1));
clu_2 = zz(rds(2));

%propose split
if clu_1 == clu_2
    %disp('propose split')
    prop_dpm = dpm;
    
    ids = find(zz == clu_1);
    
    move = rand(1,nn(clu_1)) > .5;
    moved = sum(move);
    
    if moved == 0 
        return;
    elseif moved == length(ids)
        prop_dpm.qq{clu_1} = propose_parms(prop_dpm.qq{clu_1},1);
    else %re-numbers clusters
        prop_dpm.KK = prop_dpm.KK + 1;
        prop_dpm.zz(ids(move)) = prop_dpm.KK;
        prop_dpm.nn(clu_1) = nn(clu_1) - moved;
        prop_dpm.nn(prop_dpm.KK) = moved;
        prop_dpm.qq{prop_dpm.KK} = propose_parms(prop_dpm.qq{clu_1},1);
    end
    
    %calculates q for proposal probability
    q = -log(binopdf(moved,length(ids),.5)) - ...
        parm_change_like(dpm.qq{clu_1},prop_dpm.qq{prop_dpm.KK});
    
else %propose merge
   % disp('propose merge')
    prop_dpm = dpm;
    prop_dpm.zz(dpm.zz == clu_1) = clu_2;
    prop_dpm.qq = prop_dpm.qq([1:(clu_1-1) (clu_1+1):end]);
    
    prop_dpm.nn(clu_2) = prop_dpm.nn(clu_2) + prop_dpm.nn(clu_1);
    
    %calculates q for proposal probability
    q = log(binopdf(nn(clu_1),prop_dpm.nn(clu_2),.5)) + ...
        parm_change_like(dpm.qq{clu_2},dpm.qq{clu_1});
    
    prop_dpm.nn = prop_dpm.nn([1:(clu_1-1) (clu_1+1):end]);
    prop_dpm.KK = prop_dpm.KK - 1;
    
    %re-numbers clusters
    to_fix = prop_dpm.zz > clu_1;
    prop_dpm.zz(to_fix) = prop_dpm.zz(to_fix) - 1;
    type = 1;
end
   
%calculates likelihood ratio between current and proposed DPM
rat = q + logprobdpm(prop_dpm) - logprobdpm(dpm);

%dpm = prop_dpm;

if (rat > 0) || (log(rand) < rat)
    if type == 1
        disp('merge!!')
    else
        disp('split!!');
    end
   % disp([logprobdpm(dpm) logprobdpm(prop_dpm)]);
   % disp(prop_dpm.qq{prop_dpm.KK})
    dpm = prop_dpm;
    acc = 1;
end
