% Graphs recovered parameter values against generated parameter values
%
% Run after robustness_check 
%
GRAPH_FLAG = 1;

cue_vals = [0 .5 1 1.5 2 2.5];
sal_vals = [0 .5 1 1.5 2 2.5];
assoc_vals = [0 .1 .2 .3 .4 .5];

assocs = cellfun(@(x) x.assoc, all_means);
cues = shiftdim(cellfun(@(x) x.cue, all_means),1);
sals = shiftdim(cellfun(@(x) x.sal, all_means),2);

assocs = reshape(assocs,size(assocs,1)*size(assocs,2)*size(assocs,3),1);
cues = reshape(cues,size(cues,1)*size(cues,2)*size(cues,3),1);
sals = reshape(sals,size(sals,1)*size(sals,2)*size(sals,3),1);

assoc_highs = cellfun(@(x) x.assoc_high, all_ints);
assoc_lows = cellfun(@(x) x.assoc_low, all_ints);
assoc_highs = reshape(assoc_highs,size(assocs,1)*size(assocs,2)*size(assocs,3),1);
assoc_lows = reshape(assoc_lows,size(assocs,1)*size(assocs,2)*size(assocs,3),1);

cue_highs = shiftdim(cellfun(@(x) x.cue(2), all_ints),1);
cue_lows = shiftdim(cellfun(@(x) x.cue(1), all_ints),1);
cue_highs = reshape(cue_highs,size(cues,1)*size(cues,2)*size(cues,3),1);
cue_lows = reshape(cue_lows,size(cues,1)*size(cues,2)*size(cues,3),1);

sal_highs = shiftdim(cellfun(@(x) x.sal(2), all_ints),2);
sal_lows = shiftdim(cellfun(@(x) x.sal(1), all_ints),2);
sal_highs = reshape(sal_highs,size(sals,1)*size(sals,2)*size(sals,3),1);
sal_lows = reshape(sal_lows,size(sals,1)*size(sals,2)*size(sals,3),1);

assoc_oks = reshape(ones(36,1)*assoc_vals,216,1);
assoc_under = assoc_oks > assoc_highs;
assoc_over = assoc_oks < assoc_lows;
assoc_oks = ~(assoc_over | assoc_under);

cue_oks = reshape(ones(36,1)*cue_vals,216,1);
cue_under = cue_oks > cue_highs;
cue_over = cue_oks < cue_lows;
cue_oks = ~(cue_over | cue_under);

sal_oks = reshape(ones(36,1)*sal_vals,216,1);
sal_under = sal_oks > sal_highs;
sal_over = sal_oks < sal_lows;
sal_oks = ~(sal_over | sal_under);

x = reshape(ones(36,1)*cue_vals,216,1);
stats = regstats(cues,x);
rsq = stats.rsquare;
p = stats.beta(end:-1:1);
yfit = polyval(p,cue_vals);

if GRAPH_FLAG == 1
    subplot(3,1,1);
    plot(cue_vals,yfit,'k');
    hold on;

    scatter(x,cues,[],[.6 .6 .6]);
    axis([-.5 3 -.5 3])
    set(gca,'xtick',cue_vals)
    set(gca,'ytick',cue_vals);
    xlabel('True Values','fontsize',12);
    ylabel('Inferred Values','fontsize',12);
    title('Cue','fontsize',14);
    text(-.2,2.4,['\ity\rm = ', num2str(p(1),3), ...
        '\itx\rm + ', num2str(p(2),2)], 'fontsize', 12)
    text(-.3,1.8,['\itR^2\rm = ', num2str(rsq,3)], 'fontsize', 12)
end


x = reshape(ones(36,1)*sal_vals,216,1);
stats = regstats(sals,x);
rsq = stats.rsquare;
p = stats.beta(end:-1:1);
yfit = polyval(p,sal_vals);

if GRAPH_FLAG == 1
    subplot(3,1,2);
    plot(sal_vals,yfit,'k')
    hold on

    scatter(x,sals,[],[.6 .6 .6]);
    axis([-.5 3 -.5 3])
    set(gca,'xtick',sal_vals)
    set(gca,'ytick',sal_vals);
    xlabel('True Values','fontsize',12);
    ylabel('Inferred Values','fontsize',12);
    title('Salience','fontsize',14);
    text(-.2,2.4,['\ity\rm = ', num2str(p(1),3), ...
        '\itx\rm + ', num2str(p(2),2)], 'fontsize', 12)
    text(-.3,1.8,['\itR^2\rm = ', num2str(rsq,3)], 'fontsize', 12)
end

x = reshape(ones(36,1)*assoc_vals,216,1);

stats = regstats(assocs,x);
rsq = stats.rsquare;
p = stats.beta(end:-1:1);
yfit = polyval(p,assoc_vals);

if GRAPH_FLAG == 1
    subplot(3,1,3);
    plot(assoc_vals,yfit,'k')
    hold on

    scatter(x,assocs,[],[.6 .6 .6]);
    axis([-.1 .6 -.1 .6])
    set(gca,'xtick',assoc_vals)
    set(gca,'ytick',assoc_vals);
    xlabel('True Values','fontsize',12);
    ylabel('Inferred Values','fontsize',12);
    title('Association','fontsize',14);
    text(-.036,.47,['\ity\rm = ', num2str(p(1),3), ...
        '\itx\rm + ', num2str(p(2),2)], 'fontsize', 12)
    text(-.057,.35,['\itR^2\rm = ', num2str(rsq,3)], 'fontsize', 12)
end
