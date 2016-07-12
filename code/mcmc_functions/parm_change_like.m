% Calculates the probability of switching between parameter settings
%
% Calculates the probability of switching between two different parameter
% settings based on the sampling scheme used in the Split/Merge algorithm.
% Used to calculate the acceptance probability for MCMC
%
% Arguments:
% o qq1 - the original parameter settings
% o qq2 - the new parameter settings
%
% Returns: 
% o lp - the log probability of switching from qq1 to qq2
function lp = parm_change_like(qq1,qq2)

    global SIGMA;
    
    diff = [(qq1.cue_p - qq2.cue_p) (qq1.sal_p - qq2.sal_p) ...
            (qq1.boxes_p - qq2.boxes_p) (qq1.habit_p - qq2.habit_p) ...
            (qq1.assoc_p - qq2.assoc_p)];
    lp = -normlike([0 SIGMA],diff);   
end