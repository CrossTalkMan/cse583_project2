function M = myConfusion(ground,predict,nGroups)
% ground ground truth label n*1
% predict predict label n*1
% nGroups number of groups
% class dataset used, wine etc.
% M confusion map--row:ground truth, column: predict
M = zeros(nGroups,nGroups);
for i=1:length(ground)
   if ground(i) == predict(i)
       index = ground(i);
       M(index, index) = M(index, index) + 1;
   else
       index1 = ground(i);
       index2 = predict(i);
       M(index1, index2) = M(index1, index2) + 1;
   end
end
end

