% Calculates credible intervals and other statistics for one cluster's
% parameters
%
% Given a sequence of samples of one cluseter from the DPM distribution, 
% calculates Bayesian credible intervals and other statistics for model 
% parameters. The size of the interval is specified by int_size
%
% Arguments:
%  o qqs - a cell array of MCMC samples of one cluster from the DPM 
%          distribution
%  o int_size - the size of the credible interval (e.g. .95, .68)
%
% Returns: 
% o int - credible intervals
% o med - medians for model parameters
% o means - means for model parameters
% o stds - standard deviations for model parameters
function [int med means stds] = cred_int_cluster(qqs,int_size)

sals = cellfun(@(x) x.sal_p, qqs);
sals = sort(sals);

cues = cellfun(@(x) x.cue_p, qqs);
cues = sort(cues);

boxes = cellfun(@(x) x.boxes_p, qqs,'UniformOutput',false);
boxes = vertcat(boxes{:});

habits = cellfun(@(x) x.habit_p, qqs,'UniformOutput',false);
habits = vertcat(habits{:});

assocs = cellfun(@(x) x.assoc_p, qqs,'UniformOutput',false);
assocs = vertcat(assocs{:});

START_IND = ceil((1-int_size)/2*length(cues));
END_IND = ceil((1-(1-int_size)/2)*length(cues));

int.cue = [cues(START_IND) cues(END_IND)];
int.sal = [sals(START_IND) sals(END_IND)];

med.cue = median(cues);
med.sal = median(sals);

means.cue = mean(cues);
means.sal = mean(sals);

stds.cue = std(cues);
stds.sal = std(sals);

for box = 1:size(boxes,2)
    this_box = sort(boxes(:,box));
    
    int.box_low(box) = this_box(START_IND);
    int.box_high(box) = this_box(END_IND);
    med.box(box) = median(this_box);
    means.box(box) = mean(this_box);
    stds.box(box) = std(this_box);
    
end

for habit = 1:size(habits,2)
    this_habit = sort(habits(:,habit));
    
    int.habit_low(habit) = this_habit(START_IND);
    int.habit_high(habit) = this_habit(END_IND);
    med.habit(habit) = median(this_habit);
    means.habit(box) = mean(this_habit);
    stds.habit(box) = std(this_habit);
end

for assoc = 1:size(assocs,2)
    this_assoc = sort(assocs(:,assoc));
    
    int.assoc_low(assoc) = this_assoc(START_IND);
    int.assoc_high(assoc) = this_assoc(END_IND);
    med.assoc(assoc) = median(this_assoc);
    means.assoc(assoc) = mean(this_assoc);
    stds.assoc(assoc) = std(this_assoc);
end

end