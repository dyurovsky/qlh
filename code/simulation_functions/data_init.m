% Initializes a participant's data from gaze data and experiment sturcture
%
% Makes a data structure for a participant. Calculates assocation and
% habituation matricies.
%
% Arguments:
% o data - the participant's looking data
% o structure - the participant's experimental structure
%
% Returns: 
% o data_pt - a data structure representation used by the DPM model
function data_pt = data_init(data,structure)

data_pt.structure = structure;
data_pt.data = data;

data_pt.habit_mat = get_habit_mat(data);
data_pt.assoc_mat = get_assoc_mat(data,structure);

end

