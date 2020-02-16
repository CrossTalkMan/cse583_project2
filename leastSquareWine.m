%% load data and preprocess
dataset = 'wine';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);
numGroups = length(countcats(test_labels));

test_labels = string(test_labels); % easy to compare

feature_idx = 1:size(train_featureVector,2);


train_featureVector = train_featureVector(:,feature_idx);
test_featureVector = test_featureVector(:,feature_idx);

%% calculate W
X = [ones(length(train_featureVector),1) train_featureVector];

T = zeros(length(train_featureVector),numGroups);

for i=1:length(train_labels)
   if train_labels(i,1) == '1'
       T(i,:) = [1 0 0];
   elseif train_labels(i,1) == '2'
       T(i,:) = [0 1 0];
   else
       T(i,:) = [0 0 1];
   end
end

W=X.'*X\X.'*T;

%% predict and generate confusion matrix
predictY = myPredictLeastSquare(W,test_featureVector);
confMat = myConfusionLeastSquare(test_labels,predictY ...
                                        ,numGroups,'wine')
classMat = confMat./sum(confMat,2)

test_acc = mean(diag(classMat))
test_std = std(diag(classMat))
                                    




