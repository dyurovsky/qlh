% Checks whether inference can recover ground-truth parameter values
%
% Sets cue, salience, and association to known values, generates data for
% these parameter values, and then tries to infer them from the generated
% data. 
%
cue_vals = [0 .5 1 1.5 2 2.5];
sal_vals = [0 .5 1 1.5 2 2.5];
assoc_vals = [0 .1 .2 .3 .4 .5];

all_ints = cell(length(cue_vals),length(sal_vals),length(assoc_vals));
all_means = cell(length(cue_vals),length(sal_vals),length(assoc_vals));
all_meds = cell(length(cue_vals),length(sal_vals),length(assoc_vals));
all_test_qqs = cell(length(cue_vals),length(sal_vals),length(assoc_vals));

all_cs = zeros(length(cue_vals),length(sal_vals),length(assoc_vals));
all_ps = zeros(length(cue_vals),length(sal_vals),length(assoc_vals));
all_test_cs = zeros(length(cue_vals),length(sal_vals),length(assoc_vals));
all_test_ps = zeros(length(cue_vals),length(sal_vals),length(assoc_vals));

for c_val = 1:length(cue_vals)
    for s_val = 1:length(sal_vals)
        for a_val = 1:length(assoc_vals)

            disp([c_val s_val a_val])
            tic
            
            [test_qq,data] = model_test(1,cue_vals(c_val), ...
                sal_vals(s_val), assoc_vals(a_val));
            
            all_test_qqs{c_val,s_val,a_val} = test_qq;
            
            [~,dpms] = aggregate_subjs_test;
            [ints nns meds means stds]= cred_int(dpms(200:end));
            
            all_ints{c_val,s_val,a_val} = ints{1};
            all_means{c_val,s_val,a_val} = means{1};
            all_meds{c_val,s_val,a_val} = meds{1};   
            
            [cs,ps] = cellfun(@(x) dpm_corr(x,0),dpms(200:10:end));
            all_cs(c_val,s_val,a_val) = mean(cs);
            all_ps(c_val,s_val,a_val) = sum(ps < .05)/length(ps);
            
            [cs,ps] = cellfun(@(x) dpm_corr(x,1),dpms(200:10:end));
            all_test_cs(c_val,s_val,a_val) = mean(cs);
            all_test_ps(c_val,s_val,a_val) = sum(ps < .05)/length(ps);
            
            toc
        end
    end
end