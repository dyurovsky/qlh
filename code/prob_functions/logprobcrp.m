% Log probability of a clustering using the Chinese Restaurant Process 
%
% Calculates the log probability of an observed clustering distribution
% using the Chinese Restaurant Process distribution.
%
% Arguments:
% o nn - the number of participants in each cluster
%
% Returns: 
% o logprob - the log probability of the cluster assignments
function logprob = logprobcrp(nn,aa)

logprob = gammaln(aa)+ length(nn)*log(aa) - gammaln(aa + sum(nn)) + ...
    sum(gammaln(nn));

end
