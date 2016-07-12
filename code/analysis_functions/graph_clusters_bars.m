% Graphs posterior median and cred. int. for association and cue params
%
% Graphs the median and standard error for two parameters in the Wu & 
% Kirkham simulation: association and cue. The size of each cluster 
% corresponds to the proportion of infants in that cluster. Each cluster is
% centered at the median posterior parameter value, and "error bars"
% indicate a credible interval estimate for that parameter. These intervals
% indicate the marginal credible intervals for each parameter
% independently. A better, but more computationally expensive, solution
% would be to consider the joint posterior.

function [] = graph_clusters_bars(meds,ints,c_sizes,color)

SCALE = .075;

for clu = 1:length(meds)
    
    prop = sqrt(c_sizes(clu)/sum(c_sizes)) * SCALE;
    pos = [meds{clu}.cue - prop/2, meds{clu}.assoc - prop/2, prop, prop] ;
    
    %make errorbars
    h = plot([ints{clu}.cue(1) ints{clu}.cue(2)], ...
        [meds{clu}.assoc meds{clu}.assoc], '--',...
        'LineWidth',2,'Color',color);
    
    %remove legend entries for credible intervals
    if clu ~= length(meds)
        set(get(get(h,'Annotation'),'LegendInformation'),...
            'IconDisplayStyle','off')
    end
    
    hold on;
    h = plot([meds{clu}.cue meds{clu}.cue], ...
        [ints{clu}.assoc_high ints{clu}.assoc_low], '--',...
        'LineWidth',2,'Color',color);
      
    %remove credible intervals for extra clusters
    set(get(get(h,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','off')
    
    %make ellipse
    rectangle('Position',pos,'Curvature',[1 1],'FaceColor',color,...
        'EdgeColor','k');
 
end

xlabel('Cue','fontsize',14);
ylabel('Association','fontsize',14);
axis([-.1 .65 0 .4]);
title('Parameter Posterior Distributions','fontsize',14);
daspect([1,1,1]);

end

