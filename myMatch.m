function index = myMatch(class,group)
% class class of dataset, 'wine' etc.
% group group name
% index index in which the group lives
if class == 'wine'
    index = double(group); % convert '1''2''3' to 123
end

end

