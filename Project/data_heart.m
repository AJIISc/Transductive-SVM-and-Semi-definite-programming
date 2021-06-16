%Fisher Iris data
%load fisheriris
T= readtable('heart.csv');
    
T=table2array(T);
T = T(randperm(size(T, 1)), :);
inputs=T(:,2:14);


%Y = tsne(inputs);
%inputs=Y;
%inputs=normalize(inputs);
outputs= T(:,15);

