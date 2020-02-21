function predictY = myKNN(trainData, trainLabel, testData,K)
% trainData training data on lower dimentional space d*N
% trainLabel training label with respect to training data 1*N
% testData testing data d*n
% K number of nearest neighbor

predictY = zeros(length(testData),1);
for i=1:length(testData) 
% for each test data calculate distrance with neighbor
    curr = repmat(testData(:,i),1,length(trainData));
    dist = sum((curr-trainData).^2,1);
    [~, order] = sort(dist);
    labels = trainLabel(order);
    labels = labels(1:K);
    predictY(i) = mode(labels);    
end

end