% Generates data from a known model with optional supplied parameters
%
% Creates an initial DPM according to the supplied parameters and generates
% data from it. Used for testing the robustness of the inference framework.
%
% Arguments:
% o num_groups - (optional) number of clusters in the model
% o cue_val - (optional) value of the cue parameter
% o sal_val - (optional) value of the salience paramater
% o assoc_val - (optional) value of the association parameter
%
% Returns: 
% o test_qq - the clusters in the generated model
% o test_nn - the number of participants in each cluster
function [test_qq data test_nn] = model_test(num_groups,cue_val,...
    sal_val,assoc_val)

global NUM_AOIS;

NUM_SUBJS = 10;
NUM_GROUPS = 1;

if nargin > 0
    NUM_GROUPS = num_groups;
end

cues = [0 1 2 3];
sals = [0 1 2 3];
assocs = [0 .2 .4 .6];

cues = cues(randperm(length(cues)));
sals = sals(randperm(length(sals)));
assocs = assocs(randperm(length(assocs)));

test_nn = mnrnd(NUM_SUBJS,ones(NUM_GROUPS,1)/NUM_GROUPS);

zz = arrayfun(@(x,y) y*ones(1,x),test_nn,1:NUM_GROUPS,'UniformOutput',false);
zz = horzcat(zz{:});

test_qq = cell(1,NUM_GROUPS);
data = cell(1,NUM_SUBJS);

for group = 1:NUM_GROUPS

    boxes_p = [-2 -2 -2 -2 .5] + rand(1,NUM_AOIS);
       
    if nargin >=2     
        cue_p = cue_val;
    else
        cue_p = cues(group);
    end
    
    if nargin >=3 
        sal_p = sal_val;
    else
        sal_p = sals(group);
    end
    
    if nargin >=4
        assoc_p = assoc_val;
    else
        assoc_p = assocs(group);
    end
         
    test_qq{group} = parms_init(cue_p,sal_p,boxes_p,[],assoc_p);
end

for subj = 1:NUM_SUBJS
    
    tests = [1 1 2 2];
    rnd_tst = randperm(length(tests));
    
    structure = zeros(0,NUM_AOIS);
    
    for block = 1:length(tests)
    
        block_structure = zeros(6,NUM_AOIS);
        block_structure(1:3,[3 5]) = [2 2; 2 2; 2 2];
        block_structure(4:6,[4 5]) = [2 1; 2 1; 2 1];
        block_structure(1:3,2) = 1;
        block_structure(4:6,1) = 1;

        rnd = randperm(6);
        
        block_structure = block_structure(rnd,:);
        block_structure(7,:) = [0 0 0 0 tests(rnd_tst(block))];
        
        structure = [structure; block_structure];
    end
    
    data{subj} = data_init(gen_data_pt(test_qq{zz(subj)},structure),...
        structure);
end
end