dataset = 'wine';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);

%% An example Linear Discriminant Classification


%  Classification here is based on 2 Features (featureA and feature B).  
%       You will be using all of the features but using 2 features makes it 
%       easier to visualize than the multidimensional hyperplane

featureA = 1;
featureB = 7;
feature_idx = [featureA,featureB];
numGroups = length(countcats(test_labels));
% Uncomment the following line to use all features
feature_idx = 1:size(train_featureVector,2);


train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);


%% tryLDA
train_featureVector = train_featureVector.';
test_featureVector = test_featureVector.';

% map labels to double values
train_labels = myMatch(dataset,train_labels);
test_labels = myMatch(dataset,test_labels);

x_m = mean(train_featureVector,2);
x_c1 = train_featureVector(:,1:30);
x_c2 = train_featureVector(:,31:66);
x_c3 = train_featureVector(:,67:end);

x_m_c1 = mean(x_c1,2);
x_m_c2 = mean(x_c2,2);
x_m_c3 = mean(x_c3,2);

Sw1 = 0;
Sw2 = 0;
Sw3 = 0;
for i=1:length(x_c1)
    Sw1 = Sw1 + (x_c1(:,i)-x_m_c1) * (x_c1(:,i)-x_m_c1).';
end
for i=1:length(x_c2)
    Sw2 = Sw2 + (x_c2(:,i)-x_m_c2) * (x_c2(:,i)-x_m_c2).';
end
for i=1:length(x_c3)
    Sw3 = Sw3 + (x_c3(:,i)-x_m_c3) * (x_c3(:,i)-x_m_c3).';
end

Sw = Sw1+Sw2+Sw3;

Sb = 30 * (x_m_c1-x_m)*(x_m_c1-x_m).' ...
    + 36 * (x_m_c2-x_m)*(x_m_c2-x_m).' ...
    + 24 * (x_m_c3-x_m)*(x_m_c3-x_m).';

[W, lambda] = eig(Sw\Sb);

[lambda, order] = sort(diag(lambda),'descend');

W = W(:,order);

newX=W(:,1:2).'*train_featureVector;
newTest = W(:,1:2).'*test_featureVector;

% KNN on original space
% predictLabel = myKNN(train_featureVector,train_labels,test_featureVector,3);
% KNN on projected space
predictLabel = myKNN(newX,train_labels,newTest,3);

confMat = myConfusion(test_labels,predictLabel,3)
classMat = confMat./sum(confMat,2)
test_acc = mean(diag(classMat))
test_std = std(diag(classMat))

% plot(Y(1,1:30),Y(2,1:30),'+' ...
%     ,Y(1,31:66),Y(2,31:66),'o' ...
%     ,Y(1,67:end),Y(2,67:end),'x');






