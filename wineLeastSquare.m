%% load data and preprocess
dataset = 'wine';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);
numGroups = length(countcats(test_labels));

% map labels to double values
train_labels = myMatch(dataset,train_labels);
ori = test_labels;
test_labels = myMatch(dataset,test_labels); 

feature_idx = 1:size(train_featureVector,2);

% featureA = 1;
% featureB = 7;
% feature_idx = [featureA,featureB];


train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);

%% calculate W
X = [ones(length(train_featureVector),1) train_featureVector];

T = zeros(length(train_featureVector),numGroups);

for i=1:length(train_labels)
   if train_labels(i,1) == 1
       T(i,:) = [1 0 0];
   elseif train_labels(i,1) == 2
       T(i,:) = [0 1 0];
   else
       T(i,:) = [0 0 1];
   end
end

W=X.'*X\X.'*T;

%% predict and generate confusion matrix
predictY = myPredictLeastSquare(W,test_featureVector);
confMat = myConfusion(test_labels,predictY,numGroups)
classMat = confMat./sum(confMat,2)

test_acc = mean(diag(classMat))
test_std = std(diag(classMat))

train_predictY = myPredictLeastSquare(W,train_featureVector);
train_confMat = myConfusion(train_labels,train_predictY,numGroups)
train_classMat = train_confMat./sum(train_confMat,2)

train_acc = mean(diag(train_classMat))
train_std = std(diag(train_classMat))

xvalues = {'1','2','3'};
yvalues = {'1','2','3'};
h = heatmap(xvalues,yvalues,train_confMat);
h.Title = 'Confusion Matrix';
h.XLabel = 'Predict';
h.YLabel = 'Ground Truth';

xvalues = {'1','2','3'};
yvalues = {'1','2','3'};
h = heatmap(xvalues,yvalues,confMat);
h.Title = 'Confusion Matrix';
h.XLabel = 'Predict';
h.YLabel = 'Ground Truth';
% 
% figure(1)
% myVisualizeBoundries(W,test_featureVector,ori,1,2)
% title('{\bf Classification on 2 Features of Wine}')

                                    




