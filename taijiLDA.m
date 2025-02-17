dataset = 'taiji';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);

%% An example Linear Discriminant Classification


%  Classification here is based on 2 Features (featureA and feature B).  
%       You will be using all of the features but using 2 features makes it 
%       easier to visualize than the multidimensional hyperplane

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
x_c1 = train_featureVector(:,find(train_labels==1));
x_c2 = train_featureVector(:,find(train_labels==2));
x_c3 = train_featureVector(:,find(train_labels==3));
x_c4 = train_featureVector(:,find(train_labels==4));
x_c5 = train_featureVector(:,find(train_labels==5));
x_c6 = train_featureVector(:,find(train_labels==6));
x_c7 = train_featureVector(:,find(train_labels==7));
x_c8 = train_featureVector(:,find(train_labels==8));

x_m_c1 = mean(x_c1,2);
x_m_c2 = mean(x_c2,2);
x_m_c3 = mean(x_c3,2);
x_m_c4 = mean(x_c4,2);
x_m_c5 = mean(x_c5,2);
x_m_c6 = mean(x_c6,2);
x_m_c7 = mean(x_c7,2);
x_m_c8 = mean(x_c8,2);

Sw1 = zeros(64,64);
Sw2 = zeros(64,64);
Sw3 = zeros(64,64);
Sw4 = zeros(64,64);
Sw5 = zeros(64,64);
Sw6 = zeros(64,64);
Sw7 = zeros(64,64);
Sw8 = zeros(64,64);
for i=1:length(x_c1)
    Sw1 = Sw1 + (x_c1(:,i)-x_m_c1) * (x_c1(:,i)-x_m_c1).';
end
for i=1:length(x_c2)
    Sw2 = Sw2 + (x_c2(:,i)-x_m_c2) * (x_c2(:,i)-x_m_c2).';
end
for i=1:length(x_c3)
    Sw3 = Sw3 + (x_c3(:,i)-x_m_c3) * (x_c3(:,i)-x_m_c3).';
end
for i=1:length(x_c4)
    Sw4 = Sw4 + (x_c4(:,i)-x_m_c4) * (x_c4(:,i)-x_m_c4).';
end
for i=1:length(x_c5)
    Sw5 = Sw5 + (x_c5(:,i)-x_m_c5) * (x_c5(:,i)-x_m_c5).';
end
for i=1:length(x_c6)
    Sw6 = Sw6 + (x_c6(:,i)-x_m_c6) * (x_c6(:,i)-x_m_c6).';
end
for i=1:length(x_c7)
    Sw7 = Sw7 + (x_c7(:,i)-x_m_c7) * (x_c7(:,i)-x_m_c7).';
end
for i=1:length(x_c8)
    Sw8 = Sw8 + (x_c8(:,i)-x_m_c8) * (x_c8(:,i)-x_m_c8).';
end

Sw = Sw1+Sw2+Sw3+Sw4+Sw5+Sw6+Sw7+Sw8;

Sb = 1767 * (x_m_c1-x_m)*(x_m_c1-x_m).' ...
    + 1066 * (x_m_c2-x_m)*(x_m_c2-x_m).' ...
    + 2132 * (x_m_c3-x_m)*(x_m_c3-x_m).' ...
    + 1066 * (x_m_c4-x_m)*(x_m_c4-x_m).' ...
    + 1066 * (x_m_c5-x_m)*(x_m_c5-x_m).' ...
    + 2132 * (x_m_c6-x_m)*(x_m_c6-x_m).' ...
    + 1066 * (x_m_c7-x_m)*(x_m_c7-x_m).' ...
    + 1066 * (x_m_c8-x_m)*(x_m_c8-x_m).';

[W, lambda] = eig(Sw\Sb);

[lambda, order] = sort(diag(lambda),'descend');

W = W(:,order);

newX=W(:,1:7).'*train_featureVector;
newTest = W(:,1:7).'*test_featureVector;

% KNN on original space
% predictLabel = myKNN(train_featureVector,train_labels,test_featureVector,3);
% KNN on projected space
predictLabel = myKNN(newX,train_labels,newTest,5);

confMat = myConfusion(test_labels,predictLabel,numGroups)
classMat = confMat./sum(confMat,2)
test_acc = mean(diag(classMat))
test_std = std(diag(classMat))

xvalues = unique(ori_labels);
yvalues = unique(ori_labels);
h = heatmap(xvalues,yvalues,confMat);
h.Title = 'Confusion Matrix';
h.XLabel = 'Predict';
h.YLabel = 'Ground Truth';
% 
% % plot(Y(1,1:30),Y(2,1:30),'+' ...
% %     ,Y(1,31:66),Y(2,31:66),'o' ...
% %     ,Y(1,67:end),Y(2,67:end),'x');






