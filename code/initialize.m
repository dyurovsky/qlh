% Initializes path and global variables

% initializes the path variables
addpath('analysis_functions/');
addpath('helper_functions/');
addpath('mcmc_functions/');
addpath('prob_functions/');
addpath('simulation_functions/');
addpath('simulation_functions/paper_simulations/');
addpath('results/');
addpath('results/empirical/');

% Global Constants
global NUM_AOIS; %number of aois
global HOR_RES; %horizontal monitor resolution
global VER_RES; %vertical monitor resolution

global ALPHA; %CRP hyperparameter
global SIGMA; %proposal distribution variance
global NUM_HABIT; %maximum order of habituation polynomials
global NUM_ASSOC; %maximum order of association polynomials
global NUM_PARMS; %total number of parameters

NUM_AOIS = 5;
HOR_RES = 800;
VER_RES = 600;

ALPHA = 1;
SIGMA = 1.5;
NUM_HABIT = 0;
NUM_ASSOC = 1;
NUM_PARMS = NUM_AOIS+NUM_ASSOC+NUM_HABIT+2;