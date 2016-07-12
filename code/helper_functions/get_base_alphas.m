% Calculates base alpha params for Dirichlet distributions on each trial
%
% Base alpha paramaters encode whether each AOI is cued and/or salient on
% each trial.
%
% Arguments:
%  o parms - the cognitive model parameters that define attention to cue
%            and salience for this participant.
%  o structure -  the experimental settings for this participant
%
% Returns: 
% o alphas - Dirichlet distribution alpha parameters for each trial
function alphas = get_base_alphas(parms,structure)

cue = parms.cue_p;
sal = parms.sal_p;
boxes = parms.boxes_p;

alphas = sal*issal(structure) + cue*iscued(structure);
%alphas = alphas + ones(size(alphas,1),1)*boxes;

end