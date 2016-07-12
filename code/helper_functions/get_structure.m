% Gets the structure of each experimental trial
%
% Converts from Wu & Kirkham coding to model's coding of trial type. This
% structure indicates the locations that are cued and salient, and the word
% heard on each trial.
%
% Arguments:
%  o types - a cell array of trial types in Wu & Kirkham format
%
% Returns: 
% o structure - the experimental structure for this participant
function structure = get_structure(types)

    WORDS = {'cat','dog','mumu','bounce'};
    OBJS = {'left','right'};

    word_types = zeros(length(types),1);
    for word = 1:length(WORDS)
       
        inds = ~cellfun(@isempty,strfind(types,WORDS{word}));
        word_types = word_types + (mod(word+1,2)+1)*inds;
        
    end
    
    sal_types = zeros(length(types),4);
    cue_types = sal_types;
    
    for obj = 1:length(OBJS)
       
        inds = ~cellfun(@isempty,strfind(types,OBJS{obj}));
        
        if obj == 1
            sal_types(inds,:) = repmat([0 1 1 0],sum(inds),1);
            cue_types(inds,:) = repmat([0 0 1 0],sum(inds),1);
        else
            sal_types(inds,:) = repmat([1 0 0 1],sum(inds),1);
            cue_types(inds,:) = repmat([0 0 0 1],sum(inds),1);
        end
        
    end
    
    structure = sal_types+cue_types;
    structure(:,end+1) = word_types;

end