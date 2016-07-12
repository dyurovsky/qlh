% Converts from fixations list to prop. looking to each AOI on each trial
%
% Arguments:
%  o fixes - a cell array of all fixations for one participant
%            format: [start end x y roi]
%  o trial_len - a vector of trial lengths for each trial in the experiment
%
% Returns: 
% o props - Proportion of looking to each AOI on each trial
function props = get_proportions(fixes,trial_len)

global NUM_AOIS;

%[start end x y roi] - fixation format
T_START = 1;
T_END = 2;

props = zeros(1,NUM_AOIS);

for aoi = 1:(NUM_AOIS-1)
    
   aoi_inds = fixes(:,end) == aoi;
   props(aoi) = sum(fixes(aoi_inds,T_END) - fixes(aoi_inds,T_START));
   
end

props(end) = trial_len - sum(props);

props = props./sum(props);

end