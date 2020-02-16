%% load data and preprocess
dataset = 'wallpaper';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);
numGroups = length(countcats(test_labels));

% map labels to double values
train_labels = myMatch(dataset,train_labels);
test_labels = myMatch(dataset,test_labels); 

feature_idx = 1:size(train_featureVector,2);


train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);

%% calculate W
X = [ones(length(train_featureVector),1) train_featureVector];

T = zeros(length(train_featureVector),numGroups);

for i=1:length(train_labels)
   T(i,train_labels(i,1)) = 1;
end

W=X.'*X\X.'*T;

%% predict and generate confusion matrix
predictY = myPredictLeastSquare(W,test_featureVector);
confMat = myConfusion(test_labels,predictY,numGroups)
classMat = confMat./sum(confMat,2)

test_acc = mean(diag(classMat))
test_std = std(diag(classMat))
                                    




