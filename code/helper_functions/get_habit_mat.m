% Gets the latent habituation value for each AOI on each trial
%
% Gets the latent habituation values for each AOI for each trial.
% Habituation for location l is defined as cumulative looking to l up to 
% this trial.
%
% Arguments:
%  o data - a single participant's looking data
%
% Returns: 
% o habit_mat - latent habituation for each AOI for each trial
function habit_mat = get_habit_mat(data)

habit_mat = cumsum(data);
habit_mat = [zeros(1,size(data,2)); habit_mat(1:(end-1),:)];
habit_mat(:,end) = 0;
end
