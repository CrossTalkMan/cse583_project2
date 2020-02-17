function index = myMatch(class,group)
% class class of dataset, 'wine' etc.
% group group name
% index index in which the group lives
index = zeros(size(group));
switch lower(class)
    case 'wine'
        for i=1:length(group)
            if group(i)=='1'
                index(i)=1;
            elseif group(i)=='2'
                index(i)=2;
            else
                index(i)=3;
            end
        end
    case 'taiji'
        for i=1:length(group)
            if group(i)=='0'
                index(i)=1;
            elseif group(i)=='1'
                index(i)=2;
            elseif group(i)=='2'
                index(i)=3;
            elseif group(i)=='3'
                index(i)=4;
            elseif group(i)=='5'
                index(i)=5;
            elseif group(i)=='6'
                index(i)=6;
            elseif group(i)=='7'
                index(i)=7;
            else % 9
                index(i)=8;
            end
        end
    case 'wallpaper'
        for i=1:length(group)
            if group(i)=='P1'
                index(i)=1;
            elseif group(i)=='P2'
                index(i)=2;
            elseif group(i)=='PM'
                index(i)=3;
            elseif group(i)=='PG'
                index(i)=4;
            elseif group(i)=='CM'
                index(i)=5;
            elseif group(i)=='PMM'
                index(i)=6;
            elseif group(i)=='PMG'
                index(i)=7;
            elseif group(i)=='PGG'
                index(i)=8;
            elseif group(i)=='CMM'
                index(i)=9;
            elseif group(i)=='P4'
                index(i)=10;
            elseif group(i)=='P4M'
                index(i)=11;
            elseif group(i)=='P4G'
                index(i)=12;
            elseif group(i)=='P3'
                index(i)=13;
            elseif group(i)=='P3M1'
                index(i)=14;
            elseif group(i)=='P31M'
                index(i)=15;
            elseif group(i)=='P6'
                index(i)=16;
            else % P6M
                index(i)=17;
            end
        end
end

end

