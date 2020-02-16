function index = myMatch(class,group)
% class class of dataset, 'wine' etc.
% group group name
% index index in which the group lives
index = zeros(size(group));
if class == 'wine'
    for i=1:length(group)
        if group(i)=='1'
            index(i)=1;
        elseif group(i)=='2'
            index(i)=2;
        else
            index(i)=3;
        end
    end
end

end

