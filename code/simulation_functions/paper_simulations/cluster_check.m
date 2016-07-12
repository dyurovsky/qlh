% Checks whether inference can correctly recover ground-truth clusters
%
% Sets the number of groups to several known values, generates data from
% randomly parameterized models with this number of groups, and infers the
% number of groups from this generated data
%
groups = 1:5;
NUM_RUNS = 30;

all_nns = cell(length(groups),NUM_RUNS);
test_nns = cell(length(groups),NUM_RUNS);
test_qqs = cell(length(groups),NUM_RUNS);
for group = 1:length(groups)
    for check = 1:NUM_RUNS
    
        disp([group check])
        tic

        [test_qq,data,test_nn] = model_test(group);

        test_nns{group,check} = test_nn;
        test_qqs{group,check} = test_qq;

        [~,dpms] = aggregate_subjs_test;
        [ints nns meds means stds]= cred_int(dpms(500:end));

        all_nns{group,check} = nns;
        size(nns)
        toc
    end
end
