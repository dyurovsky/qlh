% Analyses the results of the association function check
%
% Produces a table of Type I/Type II errors and also plots the estimated
% association functions against the true association functions.
%
% Run after assoc_function_check

GRAPH_FLAG = 1;

table = zeros(length(assocs),2);

for i = 1:length(assocs)
   highs = cellfun(@(x) x.assoc_high, all_ints(i,:),'UniformOutput',false);
   lows = cellfun(@(x) x.assoc_low, all_ints(i,:),'UniformOutput',false); 
   
   tops = cellfun(@(x) x(1), lows) >= .001;
   bottoms = cellfun(@(x) x(1), highs) <= -.001;
   
   table(i,1) = sum(tops | bottoms)/30;
   
   tops = cellfun(@(x) x(2), lows) >= .001;
   bottoms = cellfun(@(x) x(2), highs) <= -.001;
   
   table(i,2) = sum(tops | bottoms)/30;
end

if GRAPH_FLAG == 1

    assocs = [.5 0; -.5 0; .5 -.2; -.5 .2];

    for i = 1:size(assocs,1)

        a_vals = cellfun(@(x) x.assoc, all_means(i,:),'UniformOutput',...
            false);

        subplot(size(assocs,1)/2,size(assocs,1)/2,i);
        for j = 1:length(a_vals)
            plot(0:.01:5,polyval([a_vals{j}(end:-1:1) 0],0:.01:5),':',...
                'LineWidth',.1,'Color',[0 0 1]);
            hold on;
        end
        plot(0:.01:5,polyval([assocs(i,end:-1:1) 0],0:.01:5),'k',...
            'LineWidth',3);
        axis([0 5 -3 3]);
        hold off;

        xlabel('Accumulated Looking','fontsize',12);
        ylabel('Association','fontsize',12);
        if i > 2
            str = ['\itassoc\rm = ', num2str(assocs(i,2)), ...
                '\itx^2\rm + ', num2str(assocs(i,1)), '\itx\rm'];
        else
            str = ['\itassoc\rm = ', num2str(assocs(i,1)), '\itx\rm'];
        end

            text(.2,2.1,str,'fontsize', 12)

    end
end