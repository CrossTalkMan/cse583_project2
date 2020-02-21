dataset = 'face';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);

numGroups = length(countcats(test_labels));

% map labels to double values
ori_labels = train_labels;
train_labels = myMatch(dataset,train_labels);
test_labels = myMatch(dataset,test_labels); 

feature_idx = 1:size(train_featureVector,2);


train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);

%% calculate W for LS
X = [ones(length(train_featureVector),1) train_featureVector];

T = zeros(length(train_featureVector),numGroups);

for i=1:length(train_labels)
   T(i,train_labels(i,1)) = 1;
end

W1=X.'*X\X.'*T;

predictY = myPredictLeastSquare(W1,test_featureVector);
confMat = myConfusion(test_labels,predictY,numGroups)

%% calculate W for Fisher
train_featureVector = train_featureVector.';
test_featureVector = test_featureVector.';

x_m = mean(train_featureVector,2);
x_c1 = train_featureVector(:,18:end);
x_c2 = train_featureVector(:,1:17);

x_m_c1 = mean(x_c1,2);
x_m_c2 = mean(x_c2,2);

Sw1 = 0;
Sw2 = 0;
for i=1:size(x_c1,2)
    Sw1 = Sw1 + (x_c1(:,i)-x_m_c1) * (x_c1(:,i)-x_m_c1).';
end
for i=1:size(x_c2,2)
    Sw2 = Sw2 + (x_c2(:,i)-x_m_c2) * (x_c2(:,i)-x_m_c2).';
end

Sw = Sw1+Sw2;

Sb = 17 * (x_m_c1-x_m)*(x_m_c1-x_m).' ...
    + 17 * (x_m_c2-x_m)*(x_m_c2-x_m).';

[W2, lambda] = eig(Sw\Sb);

[lambda, order] = sort(diag(lambda),'descend');

W2 = W2(:,order);
newX=W2(:,1).'*train_featureVector;
newTest = W2(:,1).'*test_featureVector;

predictLabel = myKNN(newX,train_labels,newTest,3);

confMat2 = myConfusion(test_labels,predictLabel,numGroups)

xvalues = {'1','2'};
yvalues = {'1','2'};
h = heatmap(xvalues,yvalues,confMat);
h.Title = 'Confusion Matrix';
h.XLabel = 'Predict';
h.YLabel = 'Ground Truth';






