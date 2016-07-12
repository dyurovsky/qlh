% Analyzes the ability of inference to correctly recover clusters
%
% Determine the efficacy of inference in recovering the correct number of 
% cluster parameters by comparing ground-truth clusters to inferred
% clusters. Treats each cluster distribution as a categorical histogram and
% compares distance using MDPA
%
% Arguments:
% o test_nns - currect number of subjects in each cluster
% o all_nns - inferred number of subjects in each cluster
%
% Returns: 
% o group_diff - difference between number of clusters
% o hist_dists - distance on each run according to MDPA
function [group_diff,hist_dists] = cluster_analysis(test_nns,all_nns)

    function mean_diff = nn_diff(t_nns,a_nns)
        
        tmp_diff = inf;
        p_nns = perms(t_nns);
        
        for i = 1:size(p_nns,1)  
            mean_diff = mean(mdpa((p_nns(i,:)'*ones(1,size(a_nns,1)))',...
                a_nns));
            if mean_diff < tmp_diff
                tmp_diff = mean_diff;
            end
        end
        mean_diff = tmp_diff;
    end
        

    emp_group = cellfun(@(x) size(x,2), all_nns);
    true_group = cellfun(@(x) size(x,2), test_nns);

    group_diff = sum(sum(emp_group - true_group));

    hist_dists = cellfun(@nn_diff,test_nns,all_nns);

    bar(mean(hist_dists,2)/30,'facecolor',[.6 .6 .6]);
    axis([.5 4.5 0 .005]);
    xlabel('Number of Groups','fontsize',12);
    ylabel('Prop. Misclassified','fontsize',12);
    set(gca,'ytick',[0 .001 .002 .003 .004 .005]);
    set(gca,'yticklabel',num2str(get(gca,'ytick')'))
    title('Proportion of Infants Misclassified','fontsize',14);
    
end