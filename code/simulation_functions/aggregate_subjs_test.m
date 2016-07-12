% Runs the MCMC sampler for all participants together.
%
% Runs the MCMC sampler to generate a posterior parameter distribution for
% the Dirichlet Process Mixture Model for all participants. Starts by 
% running the sampler for each participant individually in order to 
% seed the DPM sampler.
%
% Arguments:
%  o data - the data structure for all participants
%  o group_iter - the (optional) number of iterations for which to sample 
%                 for the group. Defaults to 50000 if no value is provided.
%  o indiv_iter - the (optional) number of iterations for which to sample 
%                 for each individual. Defaults to 2000 if no value is 
%                 provided.
%  o sm_iter - the (optional) number of iterations between split/merge 
%              samples. Defaults to 100 if no value is provided.
%  o print_iter - the (optional) number of iterations between displaying 
%                 updates. Defaults to 1000 if no value is provided.
%  o thin - the (optional) thinning parameter. Defaults to 5 if no value is
%           provided.
%
% Returns: 
% o dpm_logprobs - a vector of log probabilities for each MCMC sample
% o dpms - a cell array of DPMs for each sample
% o accs - a vector of how many updates were made on each sample
function [dpm_logprobs,dpms,accs,dpm_qqs] = ...
    aggregate_subjs_test(data,group_iter,indiv_iter,sm_iter,...
    print_iter,thin)

global ALPHA;

num_subjs = length(data);

if nargin < 2
    group_iter = 50000;
end
if nargin < 3
    indiv_iter = 2000;
end
if nargin < 4
    sm_iter = 100;
end
if nargin < 5
    print_iter = 1000;
end
if nargin < 6
    thin = 5;
end

dpm_logprobs = zeros(group_iter/thin,1);
dpms = cell(group_iter/thin,1);
dpm_qqs = cell(1,num_subjs);
accs = zeros(group_iter/thin,1);

% Do individual sampling to seed the group sampler
[logprobs,qqs] = indiv_subj_test(data,indiv_iter,print_iter);
for subj = 1:num_subjs
    [~,i] = max(logprobs(:,subj));
    qq = qqs{i,subj};
    
    dpm_qqs{subj} = qq;
    
end

dpm = dpm_init(num_subjs,ALPHA,data,1:num_subjs,dpm_qqs);

pos = 1;
for iter = 1:group_iter

    if mod(iter,thin) == 0
        dpm_logprobs(pos) = logprobdpm(dpm);
        dpms{pos} = dpm;
        pos = pos + 1;
    end            

   if mod(iter,sm_iter) == 0
       [dpm,accs(pos)] = dpm_sm(dpm);
   else
       [dpm,accs(pos)] = dpm_mh(dpm);
   end
   
   if mod(iter,print_iter) == 0
       disp(['iter: ' num2str(iter) ...
      ', clusters: ' num2str(dpm.KK) ...
      ', logprob: ' num2str(logprobdpm(dpm)) ...
      ', alpha: ', num2str(dpm.aa)]);
   end
end
end