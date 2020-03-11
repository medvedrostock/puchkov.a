function [terms] = sub_vars(terms, vars, alias)
    for j = 1:length(vars)
        terms = subs(terms,...
                 vars{j}, alias{j});  
    end
end