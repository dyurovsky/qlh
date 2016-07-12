% Proposes new parameters for a cluster
%
% Proposes parameters by sampling around current parameters with a Normal
% distribution with standard deviation SIGMA. If all_flag is true, samples
% all parameters. Otherwise, samples just one parameter. In this second
% case, each parameter is equally likly to be sampled.
%
% Arguments:
% o parms - starting parameters around which to sample
% o all_flag - A boolean indicating whether all params should be sampled
% o sigma - An (optional) parameter specifying the standard deviation of
%           the gaussian used to propose parameters. Defaults to 1.5.
%
% Returns: 
% o new_parms - the new parameters after sampling 
function new_parms = propose_parms(parms,all_flag,sigma)

    global SIGMA;
    
   	if nargin < 2
        all_flag = 0;
    end
    
    if nargin >= 3
        SIGMA = sigma;
    end

    cue_p = parms.cue_p;
    sal_p = parms.sal_p;
    boxes_p = parms.boxes_p;
    habit_p = parms.habit_p;
    assoc_p = parms.assoc_p;
    
    if all_flag
        cue_p = cue_p + normrnd(0,SIGMA);
        sal_p = cue_p + normrnd(0,SIGMA); 
        boxes_p = boxes_p + normrnd(0,SIGMA,size(boxes_p)); 
        habit_p = habit_p + normrnd(0,SIGMA,size(habit_p)); 
        assoc_p = assoc_p + normrnd(0,SIGMA,size(assoc_p));
    else
    
        row_parms = [cue_p sal_p boxes_p habit_p assoc_p];

        ind = ceil(rand*length(row_parms));
        row_parms(ind) = row_parms(ind) +  normrnd(0,SIGMA);
   
        if ind == 1
            cue_p = row_parms(ind);
        elseif ind == 2
            sal_p = row_parms(ind);
        elseif (ind > 2) && (ind <= (2 + length(boxes_p)))
            boxes_p(ind-2) = row_parms(ind);
        elseif (ind > 2 + length(boxes_p)) && ...
                (ind <= (2 + length(boxes_p) + length(habit_p)))
            habit_p(ind - 2 - length(boxes_p)) = row_parms(ind);
        else
            assoc_p(ind - 2 - length(boxes_p) - length(habit_p)) = ...
                row_parms(ind);
        end
    end
    
    new_parms = parms_init(cue_p,sal_p,boxes_p,habit_p,assoc_p);
    
end