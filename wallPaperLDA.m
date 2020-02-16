dataset = 'wallpaper';
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

%% mean of all and within each class
x_m = mean(train_featureVector,2); % mean of all

x_c = zeros(500,100,17); % data of different classes(c)
for i=1:100:1601
    page=floor(i/100)+1;
    x_c(:,:,page) = train_featureVector(:,i:i+99);
end

x_cm = zeros(500,17); % mean value of each class
for i=1:17
    x_cm(:,i) = mean(x_c(:,:,i),2);
end

%% Sw
Swc = zeros(500,500,17); 
for c=1:17
% in each class
    x=x_c(:,:,c);
    for i=1:size(x,2)
        Swc(:,:,c) = Swc(:,:,c) + (x(:,i)-x_cm(:,c)) * (x(:,i)-x_cm(:,c)).';
    end   
end
Sw = sum(Swc,3);
%% Sb
Sb=zeros(500,500);
for i=1:17
    Sb = Sb + (x_cm(:,i)-x_m)*(x_cm(:,i)-x_m).';
end
Sb = 100 * Sb;

[W, lambda] = eig(Sw\Sb);

[lambda, order] = sort(diag(lambda),'descend');

W = W(:,order);

newX=W(:,1:10).'*train_featureVector;
newTest = W(:,1:10).'*test_featureVector;

% KNN on original space
% predictLabel = myKNN(train_featureVector,train_labels,test_featureVector,3);
% KNN on projected space
predictLabel = myKNN(newX,train_labels,newTest,9);

confMat = myConfusion(test_labels,predictLabel,numGroups)
classMat = confMat./sum(confMat,2)
test_acc = mean(diag(classMat))
test_std = std(diag(classMat))


%% Need a comparasion between different dimension and K of KNN






