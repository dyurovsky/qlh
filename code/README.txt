Documentation and a dependency graph for all code is available in the /doc folder. 

The /results folder contains saved .mat files for all data presented in the paper. These can be compared to self-generated results and also used to test the graphing functions.

To begin work, call the initialize function. After this, a simple place to start is to generate data from a known model, and then to recover it as in the simulations in the paper.

Below is a sample interaction
--------------------------------------------------------

>> initialize
>> test_nn

test_nn =

     4     4     2

>> test_qq{1}

ans = 

       cue_p: 1
       sal_p: 1
     boxes_p: [-1.0397 -1.5609 -1.9441 -1.9554 0.9395]
     habit_p: []
     assoc_p: 0.6000
    logprior: -1.2537

>> test_qq{2}

ans = 

       cue_p: 3
       sal_p: 2
     boxes_p: [-1.3037 -1.9014 -1.7854 -1.3332 1.2611]
     habit_p: []
     assoc_p: 0.2000
    logprior: -2.1985

>> SIGMA = 2.5;
>> [dpm_logprobs,dpms,accs,dpm_qqs] = aggregate_subjs_test(data,10000);
subj: 1, iter: 1000, logprob: 428.762
subj: 1, iter: 2000, logprob: 415.4797
subj: 2, iter: 1000, logprob: 427.9822
subj: 2, iter: 2000, logprob: 432.2329
subj: 3, iter: 1000, logprob: 410.9364
subj: 3, iter: 2000, logprob: 408.0593
subj: 4, iter: 1000, logprob: 423.5039
subj: 4, iter: 2000, logprob: 416.3976
subj: 5, iter: 1000, logprob: 491.3601
subj: 5, iter: 2000, logprob: 504.7093
subj: 6, iter: 1000, logprob: 483.4939
subj: 6, iter: 2000, logprob: 485.2638
subj: 7, iter: 1000, logprob: 505.0203
subj: 7, iter: 2000, logprob: 485.7634
subj: 8, iter: 1000, logprob: 509.6205
subj: 8, iter: 2000, logprob: 509.6114
subj: 9, iter: 1000, logprob: 324.5335
subj: 9, iter: 2000, logprob: 324.515
subj: 10, iter: 1000, logprob: 353.0889
subj: 10, iter: 2000, logprob: 347.4353
iter: 1000, clusters: 3, logprob: 4611.4211, alpha: 0.79867
iter: 2000, clusters: 3, logprob: 4600.4003, alpha: 0.29138
iter: 3000, clusters: 3, logprob: 4610.1817, alpha: 1.3714
iter: 4000, clusters: 3, logprob: 4586.4122, alpha: 0.46134
iter: 5000, clusters: 3, logprob: 4581.1478, alpha: 0.046882
iter: 6000, clusters: 3, logprob: 4575.2838, alpha: 0.042732
iter: 7000, clusters: 3, logprob: 4578.742, alpha: 0.56176
iter: 8000, clusters: 3, logprob: 4517.9549, alpha: 0.15949
iter: 9000, clusters: 3, logprob: 4570.6477, alpha: 0.44981
iter: 10000, clusters: 3, logprob: 4565.4749, alpha: 1.5042
>> dpms{end}

ans = 

    KK: 3
    NN: 10
    aa: 1.5042
    xx: {1x10 cell}
    zz: [1 1 1 1 2 2 2 2 3 3]
    nn: [4 4 2]
    qq: {[1x1 struct]  [1x1 struct]  [1x1 struct]}

 
>> dpms{end}.qq{1}

ans = 

       cue_p: 0.8537
       sal_p: 1.1438
     boxes_p: [0.0023 0.2345 0.0017 0.0241 1.4003]
     habit_p: [1x0 double]
     assoc_p: 0.6143
    logprior: 16.9387

>> dpms{end}.qq{2}

ans = 

       cue_p: 3.0261
       sal_p: 1.9372
     boxes_p: [0.1703 0.4525 0.2322 -3.1015 31.5952]
     habit_p: [1x0 double]
     assoc_p: 0.2076
    logprior: -0.7763
