% Initializes paramaters from values or by sampling from the prior dist.
%
% Creates a paramater structure for a DPM either from values passed into
% the function or by sampling values from the Jeffreys prior on parameters.
% Also calculates the logprobability of these values based on the prior.
%
% Arguments:
%  o cue_p - (optional) cue parameter value.
%  o sal_p - (optional) salience parameter value.
%  o box_p - (optional) bias parameter values for each AOI.
%            format: [BiasAOI1 BiasAOI2 ...]
%  o habit_p - (optional) habituation parameter values for each polynomial
%              coefficient.
%              format: [HabitO1 HabitO2 HabitO3...]
%  o assoc_p - (optional) assoc parameter values for each polynomial
%              coefficient.
%              format: [AssocO1 AssocO2 AssocO3...]
%
% Returns: 
%  o parms - A parameter structure for the new parameters
function parms = parms_init(cue_p,sal_p,boxes_p,habit_p,assoc_p)

    SMALL = .001;
    
    global NUM_HABIT;
    global NUM_AOIS;
    global NUM_PARMS;

    if nargin < 2 %draw parameters from Jeffrey's prior
        vars = gamrnd(SMALL,SMALL,[1 NUM_PARMS]);
        means = normrnd(0,vars,[1 NUM_PARMS]);
        
        cue_p = means(1);
        sal_p = means(2);
        boxes_p = means(3:(2+NUM_AOIS)); 
        habit_p = means((3+NUM_AOIS):(2+NUM_AOIS+NUM_HABIT));
        assoc_p = means((3+NUM_AOIS+NUM_HABIT):NUM_PARMS);
    end
    
    parms.cue_p = cue_p;
    parms.sal_p = sal_p;
    parms.boxes_p = boxes_p;
    parms.habit_p = habit_p;
    parms.assoc_p = assoc_p;
    
    row_parms = [cue_p sal_p boxes_p habit_p assoc_p];

    %Jeffreys prior on parms
    parms.logprior = logprobparms(row_parms);

end