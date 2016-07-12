% Checks whether the model can handle different kinds of assoc functions
%
% Tries 4 kinds of functions: Linear increasing, linear decreasing, 
% quadratic up, and quadratic down
%
NUM_RUNS = 30;

assocs = [.5 0; -.5 0; ...
          .5 -.2; -.5 .2];

all_ints = cell(size(assocs,1),NUM_RUNS);
all_means = cell(size(assocs,1),NUM_RUNS);
all_meds = cell(size(assocs,1),NUM_RUNS);
test_qqs = cell(size(assocs,1),NUM_RUNS);

for a_val = 1:size(assocs,1)
    for check = 1:NUM_RUNS
    
        disp([a_val check])
        tic
        
        [test_qq,data,~] = model_test(1,1,1,assocs(a_val,:));

        test_qqs{a_val,check} = test_qq;

        [~,dpms] = aggregate_subjs_test;
        [ints nns meds means stds]= cred_int(dpms(1000:end));

        all_ints{a_val,check} = ints{1};
        all_means{a_val,check} = means{1};
        all_meds{a_val,check} = meds{1};   

        toc
    end
end
