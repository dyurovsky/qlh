% Runs one round of Metropolis-Hastings Sampling for a DPM
%
% Does one round of Markov Chain Monte Carlo sampling for a Dirichlet
% Process Mixture. Uses Metropolis-Hastings with M auxiliary clusters. See:
% Neal, R. M. (2000). Markov Chain Sampling Methods for Dirichlet Process
%   Mixture Models. Journal of Computational and Graphical Statistics, 9,
%   249-265.
%
% Arguments:
% o dpm - a sample from the DPM probability distribution
%
% Returns: 
% o dpm - the new DPM sample after MH
% o acc - the number of clusters whose parameters changed in this round 
function [dpm,acc] = dpm_mh(dpm)
% run one iteration of MH sampling in the DP mixture

KK = dpm.KK; % number of active clusters
NN = dpm.NN; % number of data items
aa = dpm.aa; % alpha parameter
qq = dpm.qq; % row cell vector of mixture components
xx = dpm.xx; % row cell vector of data items
zz = dpm.zz; % row vector of cluster indicator variables
nn = dpm.nn; % row vector of number of data items per cluster

M = 2; %number of clusters to hallucinate

for ii = 1:NN % iterate over data items ii

    mm = arrayfun(@parms_init,zeros(M,1),'UniformOutput',false);
    
    % remove data item xx{ii} from component qq{kk}
    kk = zz(ii); % kk is current component that data item ii belongs to
    nn(kk) = nn(kk) - 1; % subtract from number of data items in component kk

    % compute conditional probabilities pp(kk) of data item ii
    % belonging to each component kk
    % compute probabilities in log domain, then exponentiate
    pp = log([nn (aa/M)*ones(1,M);]);
    
    for kk = 1:KK 
      pp(kk) = pp(kk) + logprobdata(xx{ii},qq{kk});
    end
    
    for kk = 1:M
        pp(KK+kk) = pp(KK+kk) + logprobdata(xx{ii},mm{kk});
    end

    pp = exp(pp - max(pp)); % -max(p) for numerical stability
    pp = pp / sum(pp);

    % choose component kk by sampling from conditional probabitilies
    kk = 1+sum(rand>cumsum(pp));

    if kk > KK
        qq{KK+1} = mm{kk - KK};
        nn(KK+1) = 0;
        kk = KK+1;
    end

    % add data item xx{ii} back into model (component qq{kk})
    zz(ii) = kk;
    nn(kk) = nn(kk) + 1; % increment number of data items in component kk
    
   % get rid of empty clusters
    to_rem = find(nn == 0);
    
    for ind = 1:length(to_rem)
        zz(zz > to_rem) = zz(zz > to_rem) - 1;
        if ind < size(to_rem)
            to_rem((ind+1):end) = to_rem((ind+1)) - 1;
        end
    end
    
    KK = sum(nn > 0);
    qq = qq(nn > 0);
    
    nn = nn(nn > 0);
    
end

% resample thetas
acc = 0;
for kk = 1:KK
    qq_p = propose_parms(qq{kk});
    
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

%resample concentration parameter
new_aa = exprnd(1);

y = logprobdpm(dpm);
y_p = y - explike(1, new_aa) + explike(1, dpm.aa);
rat = y_p - y;

if (rat > 0) || (log(rand) < rat)
        dpm.aa = new_aa;
end

end
