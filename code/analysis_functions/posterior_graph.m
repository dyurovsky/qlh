% Graphs posterior distributions for parameters from Wu & Kirkham
%
% Graphs the posterior distributions for parameter estimates for the four
% conditions in Wu & Kirkham. Error bars indicate 68% confidence interval.

load group_nocue_analysis_half
graph_clusters_bars(meds,ints,mean(nns),[0 .6 0]);

load group_8mo_face_analysis_half
graph_clusters_bars(meds,ints,mean(nns),[0 0 .6]);

load group_square_analysis_half
graph_clusters_bars(meds,ints,mean(nns),[.6 0 0]);

load group_4mo_face_analysis_half
graph_clusters_bars(meds,ints,mean(nns),[.6 .6 0]);

h = legend({'8mo NoCue','8mo Face','Square', '4mo Face'});
set(h,'Fontsize',12);