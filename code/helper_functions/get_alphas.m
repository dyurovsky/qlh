% Calculates alpha parameters for the Dirichlet distirbutions on each trial
%
% The looking expected on each trial is modeled as a Dirichlet distribution
% with parameters determined by the exponentiated product of experimental
% and subject parameters (e.g. salience, association, etc.). These
% parameters encode our prior belief about the looking patterns we are
% likely to see.
%
% Arguments:
%  o data_pt - a single participant's looking data and experimental
%              settings
%  o parms -  the cognitive model parameters for this participant
%
% Returns: 
% o alphas - Dirichlet distribution alpha parameters for each trial
function alphas = get_alphas(data_pt,parms)

alphas = get_base_alphas(parms,data_pt.structure);

habit_mat = data_pt.habit_mat;
habit = parms.habit_p;
habit_poly = [habit(end:-1:1) 0];

assoc_mat = data_pt.assoc_mat;
assoc = parms.assoc_p;
assoc_poly = [assoc(end:-1:1) 0];

alphas = exp(alphas + ...
    polyval(habit_poly,habit_mat) + polyval(assoc_poly,assoc_mat));

end