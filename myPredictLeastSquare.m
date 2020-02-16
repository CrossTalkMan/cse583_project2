function T = myPredictLeastSquare(W,testData)
% W weight matrix (D+1)*nGroup
% testData data to be predicted n*D
% T predict result n*1
T = zeros(length(testData),1); % n*nGroups
testData = [ones(length(testData),1) testData]; % n*(D+1)
for i=1:length(testData)
    max=-inf;
    index=0;
    for j=1:size(W,2)
        if testData(i,:)*W(:,j) > max
            max=testData(i,:)*W(:,j);
            index=j;
        end
    end
    T(i,1) = index;
end
return